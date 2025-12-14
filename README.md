# AI News Platform

A modern, AI-powered news aggregation platform built with Next.js 16 and React 19. This application delivers a premium reading experience with real-time AI capabilities, including personalized article recommendations and an interactive AI chat assistant.

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

## Advanced Features



## Tech Stack

*   **Framework**: Next.js 16
*   **Library**: React 19
*   **Language**: TypeScript
*   **Styling**: CSS Modules
*   **AI SDK**: Google GenAI SDK (`@google/genai`)

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

## Project Structure

*   `app/`: App Router pages and API routes.
    *   `api/`: Backend proxy/logic (Chat, Articles, Auth).
    *   `articles/`: Article listing and detail pages.
    *   `ai/`: AI-specific pages.
*   `components/`: Reusable UI components (ArticleCard, AIChatBox, etc.).
*   `lib/`: Utility functions and constants.
*   `public/`: Static assets.
*   `styles/`: Global styles and variables.
