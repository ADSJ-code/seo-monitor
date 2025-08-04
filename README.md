# Advanced SEO Position Monitor

![Ruby](https://img.shields.io/badge/Ruby-3.3.3-CC342D.svg?style=for-the-badge&logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0.2-D30001.svg?style=for-the-badge&logo=rubyonrails)
![MongoDB](https://img.shields.io/badge/MongoDB-4.7.1-47A248.svg?style=for-the-badge&logo=mongodb)
![Sidekiq](https://img.shields.io/badge/Sidekiq-8.0-red?style=for-the-badge&logo=sidekiq)
![RSpec](https://img.shields.io/badge/RSpec-3.13-68a573.svg?style=for-the-badge&logo=rspec)
![StimulusJS](https://img.shields.io/badge/Stimulus-3.2-45B1F3.svg?style=for-the-badge&logo=stimulus)

## Sumário

O Advanced SEO Position Monitor é uma aplicação web full-stack construída com Ruby on Rails. A sua principal funcionalidade é permitir aos utilizadores monitorizar o ranking de um domínio para palavras-chave específicas nos resultados de busca do Google. A aplicação utiliza um sistema de background jobs para realizar as verificações de forma assíncrona e guarda o histórico de posições para análise de performance.

Este projeto foi desenvolvido para demonstrar competências em desenvolvimento full-stack, incluindo a implementação de um sistema CRUD, modelagem de dados, execução de tarefas assíncronas, testes automatizados e interatividade no frontend.

---

## Stack de Tecnologias

* **Framework:** Ruby on Rails 8.0.2
* **Linguagem:** Ruby 3.3.3
* **Banco de Dados:** MongoDB, com Mongoid ODM
* **Background Jobs:** Sidekiq, com Redis
* **Testes:** RSpec
* **Frontend:** StimulusJS, Pico.css
* **Fonte de Dados Externos:** [SerpApi Google Search API](https://serpapi.com/)
* **Ambiente de Desenvolvimento:** Docker

---

## Funcionalidades Principais

* **Gestão de Palavras-chave:** Interface CRUD completa para adicionar, visualizar, editar e remover domínios e palavras-chave.
* **Verificação de Ranking Assíncrona:** Utiliza Sidekiq para executar as buscas na SerpApi em segundo plano, proporcionando uma experiência de utilizador fluida e sem bloqueios. A verificação pode ser disparada manualmente a partir da interface.
* **Histórico de Posições:** Cada verificação é guardada, permitindo visualizar a evolução do ranking de uma palavra-chave ao longo do tempo.
* **Testes de Modelo:** Cobertura de testes com RSpec para garantir a integridade dos dados e a lógica das associações dos modelos.
* **Interface Interativa:** Um botão na página de detalhes que, utilizando StimulusJS, dispara a verificação de ranking e exibe o status em tempo real sem precisar de recarregar a página.

---

## Como Rodar o Projeto

1.  Clone o repositório e navegue para a pasta.
2.  Instale as dependências: `bundle install`.
3.  Configure sua chave da SerpApi em `bin/rails credentials:edit`.
4.  Inicie os serviços de background: `docker start mongodb` e `docker start redis`.
5.  Para executar a aplicação, inicie os dois servidores em terminais separados:
    * Terminal 1: `bin/rails server`
    * Terminal 2: `bundle exec sidekiq`
6.  Acesse `http://localhost:3000/tracked_keywords` para usar a aplicação.

### Como Rodar os Testes
Para executar a suite de testes automatizados, use o comando:
```bash
bundle exec rspec
```