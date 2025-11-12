require 'uri' 

class SeoCheckWorker
  include Sidekiq::Worker

  def perform(tracked_keyword_id)
    tracked_keyword = TrackedKeyword.find(tracked_keyword_id)
    unless tracked_keyword
      puts "❌ Worker não conseguiu encontrar TrackedKeyword com ID: #{tracked_keyword_id}"
      return
    end

    clean_domain = URI.parse(tracked_keyword.domain).host.gsub("www.", "") rescue tracked_keyword.domain.gsub("www.", "")
    puts "🤖 Worker a verificar '#{tracked_keyword.keyword}' para o domínio limpo '#{clean_domain}' (País: #{tracked_keyword.gl}, Idioma: #{tracked_keyword.hl})..."

    found_position = nil
    
    (0..9).each do |page_number|
      start_index = page_number * 10
      
      puts "   -> Verificando Página #{page_number + 1} (Resultados #{start_index + 1} a #{start_index + 10})..."

      search = SerpApiSearch.new(
        q: tracked_keyword.keyword,
        engine: 'google',
        api_key: ENV['SERPAPI_KEY'],
        gl: tracked_keyword.gl.presence || 'br',
        hl: tracked_keyword.hl.presence || 'pt',
        start: start_index 
      )

      results = search.get_hash

      if results[:organic_results]
        results[:organic_results].each_with_index do |result, index|
          next unless result[:link]
          result_host = URI.parse(result[:link]).host.gsub("www.", "") rescue nil
          next unless result_host

          if result_host.include?(clean_domain)
            found_position = start_index + index + 1
            break
          end
        end
      else
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
      puts "✅ Posição encontrada: #{found_position}. Histórico guardado para a palavra-chave ID: #{tracked_keyword_id}."
    else
      puts "❌ Domínio não encontrado (varreu o Top 100) para a palavra-chave ID: #{tracked_keyword_id}."
    end
  end
end