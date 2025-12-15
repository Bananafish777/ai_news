# AI News Platform

A modern, AI-powered news aggregation platform built with Next.js 16 and React 19. This application delivers a premium reading experience with real-time AI capabilities, including personalized article recommendations and an interactive AI chat assistant.

## 📺 Project demo video

Available at https://drive.google.com/file/d/1d25uVXpGgnw7cKtHtVXIRj-DZrfDjmh2/view?usp=sharing

## Features

### Core Experience
*   **Article Management**: Browse a paginated list of news articles and read detailed views with rich media support.
*   **User Authentication**: Secure Login and Registration system.
*   **Bookmarking**: Save interesting articles to read later (Authenticated users only).
*   **Search**: Find articles quickly with an integrated search bar.

### AI Integration
*   **AI Chat Assistant**: An interactive chat interface powered by Google's Gemini Flash model to discuss news and answer questions.
*   **Smart Recommendations**: AI-driven recommendations to help discover relevant content.

### Modern Design
*   **Responsive UI**: Fully responsive layouts optimized for all devices.
*   **Premium Aesthetics**: Custom CSS modules offering a sleek, glassmorphism-inspired design.
*   **Interactive Components**: Smooth transitions and engagement-focused micro-interactions.

## Tech Stack

---

## **Frontend**
*   **Framework**: Next.js 16
*   **Library**: React 19
*   **Language**: TypeScript
*   **Styling**: CSS Modules
*   **AI SDK**: Google GenAI SDK (`@google/genai`)

---

## **Backend (Java / Spring Boot)**  

### **Core Technologies**
- **Language**: Java 21  
- **Framework**: Spring Boot 3  
- **Build Tool**: Maven  

### **Web & Servlet Layer**
- **Spring MVC (Servlet-based)** to build RESTful APIs.
- **Servlet fundamentals**  
  - request → filter chain → servlet → response 
  - servlet thread model  
  - lifecycle & dispatching  
- **HTTP / Networking Layer**
  - HTTP/1.1 request–response model
  - CORS policies  
  - Stateless JWT authentication  
  - Java `HttpClient` for external news API & RSS fetching  

### **Security**
- Spring Security 6  
- JWT-based authentication  
- Password Encoding (BCrypt)  
- CORS + CSRF policies  

### **Database & Persistence**
- **PostgreSQL** (Render-hosted)  
- Spring Data JPA / Hibernate ORM  
- Migrations via Flyway  
- Connection pooling (HikariCP)  

### **Business Logic Layer**
- News aggregation pipeline (fetch → normalize → dedupe → persist)  
- Topic–article mapping  
- User follow / notification subsystem  
- Scheduled tasks (Spring Scheduling)  


## **DevOps / Deployment**
- **Render Cloud**:  
  - Backend deployed as a Render Web Service  
  - Database deployed as Render PostgreSQL Instance  
- **Local Development**  
  - Frontend: `npm run dev` → http://localhost:3000  
  - Backend (remote): base URL provided via `NEXT_PUBLIC_API_BASE_URL`  
- **Environment Configurations**
  - Backend uses Render Environment Variables  
  - Frontend uses `.env.local` (not committed)  

---

## Getting Started

Follow these steps to set up and run the project locally.

### Prerequisites
*   Node.js 18+ installed on your machine.
*   A Google Gemini API key.

### Installation

1.  Clone the repository:
    ```bash
    git clone <repository_url>
    cd ai_news
    ```

2.  Install dependencies:
    ```bash
    npm install
    ```

3.  Set up environment variables:
    Create a `.env.local` file in the root directory and add the following keys:

    ```env
    # Gemini API Key for AI Chat
    GEMINI_API_KEY=your_gemini_api_key_here

    # Backend API URL (Optional, defaults to production mock if not set)
    NEXT_PUBLIC_API_BASE_URL=https://ai-news-1-pcrx.onrender.com/api
    ```

### Running the App

Run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

** Note: ** the backend structure was deployed on Render remotely as a free instance, the service might be halted due to long time inactivity. Please contact us when the service stopped.

## Project Structure

### Frontend

*   `app/`: App Router pages and API routes.
    *   `api/`: Backend proxy/logic (Chat, Articles, Auth).
    *   `articles/`: Article listing and detail pages.
    *   `ai/`: AI-specific pages.
*   `components/`: Reusable UI components (ArticleCard, AIChatBox, etc.).
*   `lib/`: Utility functions and constants.
*   `public/`: Static assets.
*   `styles/`: Global styles and variables.

### Backend: 
* ai_news/backend/src/main/java/com/example/news_project
  * `configuration/`: Global config (CORS, JWT filters, Web MVC settings)
  * `controller/ `: REST API endpoints exposed to the frontend
  * `dto/`: Request/response data models used by controllers
  * `exception/`: Custom exceptions + global exception handler (ControllerAdvice)
  * `model/`: JPA entity classes mapped to PostgreSQL tables    
  * `security/`: Security configuration, JWT authentication, password encoding, filters, user details .etc
  * `repository/`: Spring Data JPA repositories for database operations
  * `service/`: Business logic layer

* This structure ensures a clean separation between:
    - **Web layer** (controllers & DTOs)  
    - **Business logic** (services)  
    - **Persistence** (models & repositories)  
    - **Security** (JWT, filters, auth)  
    - **Configuration** (CORS, scheduling, application-wide setups)

## Project code
Available at https://github.com/Bananafish777/ai_news.git
