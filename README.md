# Advanced SEO Position Monitor

![Ruby](https://img.shields.io/badge/Ruby-3.3.3-CC342D.svg?style=for-the-badge&logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.0.2-D30001.svg?style=for-the-badge&logo=rubyonrails)
![MongoDB](https://img.shields.io/badge/MongoDB-4.7.1-47A248.svg?style=for-the-badge&logo=mongodb)
![Sidekiq](https://img.shields.io/badge/Sidekiq-8.0-red?style=for-the-badge&logo=sidekiq)
![RSpec](https://img.shields.io/badge/RSpec-3.13-68a573.svg?style=for-the-badge&logo=rspec)
![StimulusJS](https://img.shields.io/badge/Stimulus-3.2-45B1F3.svg?style=for-the-badge&logo=stimulus)

## Summary

The Advanced SEO Position Monitor is a full-stack web application built with Ruby on Rails. Its main functionality is to allow users to monitor a domain's ranking for specific keywords in Google search results. The application uses a background job system to perform checks asynchronously and saves the position history for performance analysis.

This project was developed to demonstrate full-stack development skills, including implementing a CRUD system, data modeling, asynchronous task execution, automated testing, and frontend interactivity.

---

## Tech Stack

* **Framework:** Ruby on Rails 8.0.2
* **Language:** Ruby 3.3.3
* **Database:** MongoDB (with Mongoid ODM)
* **Background Jobs:** Sidekiq (with Redis)
* **Testing:** RSpec
* **Frontend:** StimulusJS, Pico.css
* **External Data Source:** [SerpApi Google Search API](https://serpapi.com/)
* **Development Environment:** Docker & Docker Compose

---

## Core Features

* **Keyword Management:** Full CRUD interface to add, view, edit, and remove domains and keywords.
* **Asynchronous Rank Checking:** Uses Sidekiq to execute searches on the SerpApi in the background, providing a fluid, non-blocking user experience. Checks can be manually triggered from the UI.
* **Position History:** Every check is saved, allowing users to visualize the evolution of a keyword's ranking over time.
* **Model Tests:** RSpec test coverage to ensure data integrity and model association logic.
* **Interactive UI:** A button on the details page that, using StimulusJS, triggers the rank check and displays the status in real-time without a page reload.

---

## How to Run the Project

This project is fully containerized using Docker.

1.  Clone the repository:
    `git clone https://github.com/ADSJ-code/seo-monitor.git`

2.  Navigate into the project directory:
    `cd seo-monitor`

3.  Create your local environment file from the example:
    `cp .env.example .env`

4.  Edit the `.env` file (e.g., `nano .env`) and add your `SERPAPI_KEY`.

5.  Build the images and start all services (web, worker, db, redis):
    `docker compose up --build`

The application will be available at `http://localhost:3000`.

---

## How to Run Tests

With the application services running (after `docker compose up`), open a **new terminal window** and run the RSpec suite inside the web container:

```bash
docker compose exec web bundle exec rspec