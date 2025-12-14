import { NextResponse } from 'next/server';
import { API_BASE_URL } from '../../../../lib/constants';

export async function POST(request: Request) {
    const body = await request.json();
    console.log('[Login Route] Received body:', body);

    try {
        console.log('[Login Route] Sending to backend:', `${API_BASE_URL}/auth/login`);
        const response = await fetch(`${API_BASE_URL}/auth/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(body),
        });

        const data = await response.json();

        if (!response.ok) {
            return NextResponse.json(data, { status: response.status });
        }

        const nextResponse = NextResponse.json(data);

        // Check for token in common fields and set cookie
        const token = data.token || data.access_token;
        if (token) {
            nextResponse.cookies.set('token', token, {
                httpOnly: true,
                secure: process.env.NODE_ENV === 'production',
                path: '/',
                maxAge: 60 * 60 * 24 * 7 // 1 week
            });
        }

        return nextResponse;
    } catch (error) {
        return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
    }
}
