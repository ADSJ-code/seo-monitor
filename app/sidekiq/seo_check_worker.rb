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

    puts "🤖 Worker a verificar '#{tracked_keyword.keyword}' para o domínio limpo '#{clean_domain}'..."

    search = SerpApiSearch.new(
      q: tracked_keyword.keyword,
      engine: 'google',
      api_key: ENV['SERPAPI_KEY'],
      num: 100
    )

    results = search.get_hash

    found_position = nil
    if results[:organic_results]
      results[:organic_results].each_with_index do |result, index|
        next unless result[:link]

        result_host = URI.parse(result[:link]).host.gsub("www.", "") rescue nil
        next unless result_host

        if result_host.include?(clean_domain)
          found_position = index + 1
          break
        end
      end
    end

    if found_position
      RankingHistory.create!(
        tracked_keyword: tracked_keyword,
        position: found_position,
        checked_on: Date.today
      )
      puts "✅ Posição encontrada: #{found_position}. Histórico guardado para a palavra-chave ID: #{tracked_keyword_id}."
    else
      puts "❌ Domínio não encontrado para a palavra-chave ID: #{tracked_keyword_id}."
    end
  end
end