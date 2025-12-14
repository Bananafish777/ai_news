import { API_BASE_URL } from '../../../lib/constants';
import { cookies } from 'next/headers';

export interface ArticleSource {
    id: number;
    name: string;
}

export interface ArticleContent {
    url: string;
    content: string;
}

export interface ArticleMedia {
    url: string;
    type: string;
    size: number;
}

export interface Article {
    id: number;
    source: ArticleSource;
    url?: string;
    title: string;
    author: string | null;
    update_time?: string;
    content?: ArticleContent[];
    media?: ArticleMedia[];
    topic?: any[];
    bookmark?: {
        bookmarked: boolean;
    };
    history?: any;
}

export interface ArticlesResponse {
    items: Article[];
    page: number;
    page_size: number;
    total: number;
}

export async function fetchArticles(page: number = 1, pageSize: number = 10): Promise<{ items: Article[]; total: number }> {
    try {
        const queryString = new URLSearchParams({
            page: page.toString(),
            page_size: pageSize.toString(),
        }).toString();

        const response = await fetch(`${API_BASE_URL}/articles?${queryString}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
            next: { revalidate: 60 } // Cache for 60 seconds
        });

        if (!response.ok) {
            throw new Error(`Failed to fetch articles: ${response.status} ${response.statusText}`);
        }

        const data: ArticlesResponse = await response.json();
        return { items: data.items, total: data.total };
    } catch (error) {
        console.error('Error fetching articles, using mock data:', error);
        // Fallback to empty or mock if needed
        return { items: [], total: 0 };
    }
}

import { cache } from 'react';

export const fetchArticleById = cache(async function (id: number): Promise<Article | null> {
    console.time(`fetchArticleById-${id}`);
    try {
        const cookieStore = await cookies();
        const token = cookieStore.get('token')?.value;

        const headers: HeadersInit = {
            'Content-Type': 'application/json',
        };

        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        }

        const response = await fetch(`${API_BASE_URL}/articles/${id}`, {
            method: 'GET',
            headers,
            next: { revalidate: 60 }
        });

        console.timeEnd(`fetchArticleById-${id}`);

        if (response.status === 404) {
            return null;
        }

        if (response.status === 403 || response.status === 401) {
            throw new Error('Unauthorized');
        }

        if (!response.ok) {
            console.error(`Failed to fetch article: ${response.status} ${response.statusText}`);
            return null;
        }

        const data = await response.json();

        // Handle case where API returns an array [Article] for ID lookup
        if (Array.isArray(data)) {
            return data.length > 0 ? data[0] : null;
        }

        return data as Article;
    } catch (error: any) {
        console.timeEnd(`fetchArticleById-${id}`);
        if (error.message === 'Unauthorized') {
            throw error;
        }
        console.error('Error fetching article by ID:', error);
        return null;
    }
});

