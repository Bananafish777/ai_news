import { API_BASE_URL } from '../../../lib/constants';
import { cookies } from 'next/headers';
import { cache } from 'react';


export interface Bookmark {
    articleId: number;
    createAt: string;
}

export const fetchBookmarks = cache(async function (): Promise<Bookmark[]> {
    try {
        const cookieStore = await cookies();
        const token = cookieStore.get('token')?.value;

        if (!token) {
            throw new Error('Unauthorized');
        }

        const response = await fetch(`${API_BASE_URL}/bookmarks/me`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            next: { revalidate: 0 } // Don't cache bookmarks listing aggressively as it changes on user action
        });

        if (response.status === 401 || response.status === 403) {
            throw new Error('Unauthorized');
        }

        if (!response.ok) {
            throw new Error('Failed to fetch bookmarks');
        }

        const data = await response.json();
        return data; // returns array of Bookmark
    } catch (error) {
        console.error('Error fetching bookmarks:', error);
        throw error;
    }
});
