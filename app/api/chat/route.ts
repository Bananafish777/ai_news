import { NextResponse } from 'next/server';
import { GoogleGenAI } from "@google/genai";

export async function POST(req: Request) {
    try {
        const { message, history, context } = await req.json();

        // Validating API Key existence explicitly, though SDK might handle it.
        if (!process.env.GEMINI_API_KEY) {
            return NextResponse.json(
                { error: 'Gemini API Key not configured' },
                { status: 500 }
            );
        }

        // Initialize the GoogleGenAI client
        // It automatically reads GEMINI_API_KEY from process.env if available, 
        // but passing it explicitly ensures Next.js env vars are picked up correctly.
        const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });

        // Construct prompt with context and history
        const historyText = history
            .map((msg: any) => `${msg.role === 'user' ? 'User' : 'Assistant'}: ${msg.text}`)
            .join('\n');

        let prompt = '';
        if (context) {
            prompt = `
    You are a helpful news assistant. You are analyzing the following news article:
    <Article>
    ${context}
    </Article>

    Here is the conversation history:
    ${historyText}

    User: ${message}
    Assistant:
    `;
        } else {
            prompt = `
    You are a helpful news assistant.
    
    Here is the conversation history:
    ${historyText}

    User: ${message}
    Assistant:
    `;
        }

        // Call the Gemini API using the new SDK method
        const response = await ai.models.generateContent({
            model: "gemini-2.5-flash",
            contents: prompt,
        });

        // The new SDK response structure:
        const reply = response.text || "I couldn't generate a response.";

        return NextResponse.json({ reply });

    } catch (error: any) {
        console.error('API Route Error:', error);
        return NextResponse.json(
            { error: error.message || 'Internal Server Error' },
            { status: 500 }
        );
    }
}
