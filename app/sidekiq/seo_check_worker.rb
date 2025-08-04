# app/sidekiq/seo_check_worker.rb
class SeoCheckWorker
  include Sidekiq::Worker

  # O método perform é o que o Sidekiq executa
  def perform(tracked_keyword_id)
    tracked_keyword = TrackedKeyword.find(tracked_keyword_id)

    unless tracked_keyword
      puts "❌ Worker não conseguiu encontrar TrackedKeyword com ID: #{tracked_keyword_id}"
      return
    end

    puts "🤖 Worker a verificar '#{tracked_keyword.keyword}' para o domínio '#{tracked_keyword.domain}'..."

    search = SerpApiSearch.new(
      q: tracked_keyword.keyword,
      engine: 'google',
      api_key: Rails.application.credentials.serpapi[:api_key]
    )

    results = search.get_hash

    found_position = nil
    if results[:organic_results]
      results[:organic_results].each_with_index do |result, index|
        if result[:link] && result[:link].include?(tracked_keyword.domain)
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