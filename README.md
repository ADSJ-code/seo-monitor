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

---

## 🏁 How to Run (One-Command Setup)

This project is fully containerized using Docker Compose. It includes advanced Health Checks to guarantee zero Race Conditions between the four services (Web, Sidekiq, MongoDB, Redis).

### 1. Configuration

1.  Clone and acess the repository:
    ```bash
    git clone https://github.com/ADSJ-code/seo-monitor
    ```

    ```bash
    cd seo-monitor
    ```

2.  Create your environment file by copying the example:
    ```bash
    cp .env.example .env
    ```

3.  **Critical Step:** Edit the `.env` file and add your personal SerpApi API Key:
    ```bash
    nano .env
    ```
    Or

    ```bash
    code .env
    ```

    ```
    SERPAPI_API_KEY="YOUR_API_KEY_HERE"
    ```

### 2. Start Services and Validate

Execute this single command to **build the images**, **start all 4 services**, and run the **database setup** automatically in the background:

```bash
docker-compose up --build -d
```

### 3. Verification and Access

1. Check Service Health: Wait 15-30 seconds, then check the status. All 4 services must show (healthy).

```bash
docker-compose ps
```

2. Access the Application: Once all services are healthy, open your browser:

Web Application: http://localhost:3000 (Assuming port 3000 is configured)

Stop Services: To cleanly stop and remove the containers:

```bash
docker-compose down
```