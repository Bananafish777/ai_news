'use client';
import { useState } from 'react';
import styles from './AIChatBox.module.css';

interface AIChatBoxProps {
    context?: string;
}

const AIChatBox = ({ context = '' }: AIChatBoxProps) => {
    const [messages, setMessages] = useState([
        {
            role: 'ai',
            text: context
                ? 'Hi! I’ve read this article. Ask me anything about it.'
                : 'Hi! I am your AI news assistant. Ask me anything.'
        }
    ]);
    const [input, setInput] = useState('');
    const [isLoading, setIsLoading] = useState(false);

    const handleSend = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!input.trim()) return;

        const userMsg = input;
        setMessages(prev => [...prev, { role: 'user', text: userMsg }]);
        setInput('');
        setIsLoading(true);

        try {
            const response = await fetch('/api/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    message: userMsg,
                    history: messages,
                    context: context
                })
            });

            const data = await response.json();

            if (data.error) throw new Error(data.error);

            setMessages(prev => [...prev, {
                role: 'ai',
                text: data.reply
            }]);
        } catch (error) {
            console.error('Chat error:', error);
            setMessages(prev => [...prev, {
                role: 'ai',
                text: 'Sorry, I encountered an error connecting to the AI.'
            }]);
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className={styles.container}>
            <div className={styles.header}>
                <div className={styles.badge}>DEMO</div>
                <h3>AI Assistant</h3>
            </div>

            <div className={styles.messages}>
                {messages.map((msg, idx) => (
                    <div key={idx} className={`${styles.message} ${msg.role === 'user' ? styles.user : styles.ai}`}>
                        <div className={styles.bubble}>
                            {msg.text}
                        </div>
                    </div>
                ))}
                {isLoading && (
                    <div className={`${styles.message} ${styles.ai}`}>
                        <div className={styles.bubble}>Thinking...</div>
                    </div>
                )}
            </div>

            <form onSubmit={handleSend} className={styles.inputArea}>
                <input
                    type="text"
                    className={styles.input}
                    placeholder="Ask about this article..."
                    value={input}
                    onChange={(e) => setInput(e.target.value)}
                />
                <button type="submit" className={styles.sendBtn} disabled={isLoading}>
                    ➤
                </button>
            </form>
        </div>
    );
};

export default AIChatBox;
