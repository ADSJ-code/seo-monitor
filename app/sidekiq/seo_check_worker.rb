require 'uri' 
require 'serpapi' 

class SeoCheckWorker
  include Sidekiq::Worker

  def perform(tracked_keyword_id)
    tracked_keyword = TrackedKeyword.find_by(id: tracked_keyword_id)
    unless tracked_keyword
      Rails.logger.error "Worker não conseguiu encontrar TrackedKeyword com ID: #{tracked_keyword_id}"
      return
    end

    clean_domain = URI.parse(tracked_keyword.domain).host.gsub("www.", "") rescue tracked_keyword.domain.gsub("www.", "")
    clean_domain_downcased = clean_domain.downcase
    
    Rails.logger.info "Worker a verificar '#{tracked_keyword.keyword}' para o domínio limpo '#{clean_domain_downcased}' (País: #{tracked_keyword.gl}, Idioma: #{tracked_keyword.hl})..."

    found_position = nil
    
    begin
      (0..9).each do |page_number|
        start_index = page_number * 10
        Rails.logger.info "Verificando Página #{page_number + 1} (Resultados #{start_index + 1} a #{start_index + 10})..."

        params = {
          api_key: ENV['SERPAPI_API_KEY'],
          engine: 'google',
          q: tracked_keyword.keyword,
          gl: tracked_keyword.gl.presence || 'br',
          hl: tracked_keyword.hl.presence || 'pt',
          start: start_index 
        }

        client = SerpApi::Client.new(params)
        results = client.search
        
        if results[:error]
          Rails.logger.error "A API da SerpApi retornou um ERRO: #{results[:error]}"
          tracked_keyword.update(status: 'API Error', error_message: results[:error])
          break 
        end

        if results[:organic_results]
          results[:organic_results].each_with_index do |result, index|
            next unless result[:link]
            
            result_host = URI.parse(result[:link]).host&.gsub("www.", "")&.downcase rescue nil
            next unless result_host

            if result_host.include?(clean_domain_downcased) || clean_domain_downcased.include?(result_host)
              found_position = start_index + index + 1
              break
            end
          end
        else
          Rails.logger.warn "Nenhum 'organic_results' retornado pela API na página #{page_number + 1}."
          break 
        end

        break if found_position.present?
      end

      if found_position
        RankingHistory.create!(
          tracked_keyword: tracked_keyword,
          position: found_position,
          checked_on: Date.today
        )
        tracked_keyword.update(status: 'Completed', error_message: nil)
        Rails.logger.info "Posição encontrada: #{found_position}. Histórico guardado para a palavra-chave ID: #{tracked_keyword_id}."
      else
        tracked_keyword.update(status: 'Not Found', error_message: nil)
        Rails.logger.warn "Domínio não encontrado (varreu o Top 100) para a palavra-chave ID: #{tracked_keyword_id}."
      end
      
    rescue SerpApi::SerpApiError => e
      tracked_keyword.update(status: 'API Error', error_message: e.message)
      Rails.logger.error "Erro da SerpApi para ID #{tracked_keyword_id}: #{e.message}"
    rescue StandardError => e
      tracked_keyword.update(status: 'Processing Error', error_message: e.message)
      Rails.logger.fatal "Erro geral no Worker ID #{tracked_keyword_id}: #{e.message}"
    end
  end
end