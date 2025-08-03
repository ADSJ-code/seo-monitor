# lib/tasks/seo_checker.rake
namespace :seo_checker do
  desc "Verifica a posição de todos os TrackedKeywords no Google e guarda o histórico"
  task check_rankings: :environment do
    puts "🤖 Iniciando o robô de verificação de SEO..."

    tracked_keywords = TrackedKeyword.all

    if tracked_keywords.empty?
      puts "ℹ️ Nenhuma palavra-chave para verificar. Adicione algumas em http://localhost:3000/tracked_keywords"
      next
    end

    puts "🔎 Encontradas #{tracked_keywords.count} palavras-chave para verificar."

    tracked_keywords.each do |tk|
      puts "--- Verificando '#{tk.keyword}' para o domínio '#{tk.domain}'..."

      # Configura a busca na SerpApi
      search = SerpApiSearch.new(
        q: tk.keyword,
        engine: 'google',
        api_key: Rails.application.credentials.serpapi[:api_key]
      )
      
      results = search.get_hash

      # Procura o nosso domínio nos resultados e encontra a posição
      found_position = nil
      if results[:organic_results]
        results[:organic_results].each_with_index do |result, index|
          if result[:link] && result[:link].include?(tk.domain)
            found_position = index + 1 # A posição é o índice do array + 1
            break # Para o loop assim que encontrar a primeira ocorrência
          end
        end
      end

      if found_position
        # Guarda o resultado no histórico
        RankingHistory.create!(
          tracked_keyword: tk,
          position: found_position,
          checked_on: Date.today
        )
        puts "✅ Posição encontrada: #{found_position}. Histórico guardado."
      else
        puts "❌ Domínio não encontrado nos 100 primeiros resultados para esta palavra-chave."
      end
    end

    puts "🏆 Verificação concluída!"
  end
end