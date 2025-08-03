# SEO Position Monitor

![Ruby](https://img.shields.io/badge/Ruby-3.3.3-CC342D.svg?style=for-the-badge&logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0.2-D30001.svg?style=for-the-badge&logo=rubyonrails)
![MongoDB](https://img.shields.io/badge/MongoDB-4.7.1-47A248.svg?style=for-the-badge&logo=mongodb)
![Sidekiq](https://img.shields.io/badge/Sidekiq-8.0-red?style=for-the-badge&logo=sidekiq)

## Sumário

O SEO Position Monitor é uma aplicação web full-stack construída com Ruby on Rails. A sua principal funcionalidade é permitir que os utilizadores monitorizem o ranking de um domínio para palavras-chave específicas nos resultados de busca orgânica do Google. A aplicação guarda o histórico de posições ao longo do tempo, permitindo uma análise da performance de SEO.

Este projeto foi desenvolvido para demonstrar competências em desenvolvimento full-stack, incluindo a criação de interfaces CRUD, modelagem de dados com associações (one-to-many), e a execução de tarefas de coleta de dados através de APIs externas.

---

## Arquitetura do Sistema

A aplicação utiliza uma arquitetura MVC (Model-View-Controller) padrão do Rails para gerir a interface do utilizador e as operações CRUD sobre as palavras-chave monitorizadas. A coleta de dados é realizada por uma Rake task desacoplada, projetada para ser executada periodicamente. Esta tarefa itera sobre todos os registos de `TrackedKeyword`, consulta a API da SerpApi para cada um, analisa os resultados da busca para encontrar a posição do domínio especificado e, por fim, persiste essa informação como um novo registo de `RankingHistory` associado.

---

## Stack de Tecnologias

* **Framework:** Ruby on Rails 8.0.2
* **Linguagem:** Ruby 3.3.3
* **Banco de Dados:** MongoDB, com Mongoid ODM
* **Tarefas em Segundo Plano:** Sidekiq (dependência adicionada para futura implementação de jobs automáticos)
* **Fonte de Dados Externos:** [SerpApi Google Search API](https://serpapi.com/)
* **Estilo Visual:** Pico.css
* **Ambiente de Desenvolvimento:** Docker (para o serviço MongoDB)

---

## Pré-requisitos

Para executar este projeto localmente, certifique-se de que possui:
* Ruby (gerenciado via `rbenv` ou similar)
* Bundler
* Docker Desktop
* Uma chave de API da [SerpApi](https://serpapi.com/)

---

## Configuração e Instalação

Siga os passos abaixo para configurar o ambiente de desenvolvimento.

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/ADSJ-code/seo-monitor.git](https://github.com/ADSJ-code/seo-monitor.git)
    ```

2.  **Navegue para o diretório do projeto:**
    ```bash
    cd seo-monitor
    ```

3.  **Instale as dependências do Ruby:**
    ```bash
    bundle install
    ```

4.  **Configure as credenciais:**
    Execute o comando abaixo para abrir o editor de credenciais do Rails:
    ```bash
    bin/rails credentials:edit
    ```
    Insira sua chave da SerpApi no seguinte formato e salve o arquivo:
    ```yaml
    serpapi:
      api_key: "SUA_CHAVE_DA_SERPAPI_AQUI"
    ```

5.  **Inicie o serviço do MongoDB via Docker:**
    ```bash
    docker run --name mongodb -d -p 27017:27017 mongo
    ```

---

## Utilização

### 1. Iniciar a Aplicação
Inicie o servidor Rails:
```bash
bin/rails server
```
Acesse a aplicação no seu navegador em `http://localhost:3000/tracked_keywords`. Através da interface, você pode adicionar, editar e remover as palavras-chave que deseja monitorizar.

### 2. Executar a Verificação de Ranking
Para popular o histórico de posições, execute a Rake task de verificação. A tarefa irá percorrer todas as palavras-chave que você salvou através da interface.
```bash
bin/rails seo_checker:check_rankings
```
Após a execução, o histórico de ranking será visível na página de detalhes de cada palavra-chave.
