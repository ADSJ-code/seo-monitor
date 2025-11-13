# SEO Monitor (Portfolio Project)

SEO Monitor is a full-stack web application built with Ruby on Rails that allows users to track their domain's Google ranking for specific keywords. This project demonstrates asynchronous job processing (Sidekiq/Redis), NoSQL persistence (MongoDB), and third-party API integration (SerpApi).

The application is fully internationalized (i18n) and automatically detects the user's browser language (English and Portuguese-BR supported).

---

## 🚀 Tech Stack

* **Backend:** Ruby on Rails 8
* **Database:** MongoDB (via Mongoid)
* **Background Jobs:** Sidekiq
* **Queue & Cache:** Redis
* **External API:** SerpApi (for Google Ranking data)
* **Containerization:** Docker Compose
* **i18n:** `http_accept_language`

---

## 🏁 How to Run (Docker)

This project is fully containerized. You only need Docker and Docker Compose installed to run it.

### 1. Configuration

1.  Clone the repository:
    ```bash
    git clone [URL_DO_SEU_REPOSITORIO]
    cd seo-monitor
    ```

2.  Create your environment file by copying the example:
    ```bash
    cp .env.example .env
    ```

3.  Edit the `.env` file and add your personal SerpApi API Key:
    ```bash
    nano .env
    ```
    ```
    SERPAPI_API_KEY="YOUR_API_KEY_HERE"
    ```

### 2. Run the Application

With Docker running, execute the following commands in your terminal:

```bash
# 1. Build the images (This may take a few minutes the first time)
docker-compose build

# 2. Start all services (Web, Sidekiq, DB, and Redis)
docker-compose up