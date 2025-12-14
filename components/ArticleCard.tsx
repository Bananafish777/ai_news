'use client';
import Link from 'next/link';
import { useState } from 'react';
import styles from './ArticleCard.module.css';

interface ArticleCardProps {
    title: string;
    summary: string;
    source: string;
    time: string;
    imageUrl?: string;
    id: string;
}

const ArticleCard = ({ title, summary, source, time, imageUrl, id }: ArticleCardProps) => {
    const [isBookmarked, setIsBookmarked] = useState(false);
    const [isLoading, setIsLoading] = useState(false);

    const handleBookmark = async (e: React.MouseEvent) => {
        e.preventDefault();
        e.stopPropagation();

        if (isLoading) return;
        setIsLoading(true); // Don't block toggle purely on UI for now, but prevent double clicks

        try {
            const response = await fetch(`/api/bookmarks/add/${id}`, {
                method: 'POST'
            });

            if (response.ok) {
                setIsBookmarked(true);
                alert('Bookmarked successfully!');
            } else if (response.status === 401) {
                alert('Please sign in to bookmark articles.');
                // Optional: redirect to login
                // window.location.href = '/login';
            } else {
                const data = await response.json();
                alert(data.error || 'Failed to bookmark');
            }
        } catch (error) {
            console.error('Bookmark error:', error);
            alert('An error occurred.');
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className={styles.cardWrapper}>
            <Link href={`/articles/${id}`} className={styles.card}>
                <div className={styles.content}>
                    <div className={styles.topRow}>
                        <div className={styles.meta}>
                            <span className={styles.source}>{source}</span>
                            <span className={styles.time}>{time}</span>
                        </div>
                        {/* Prevent Link navigation when clicking button by using z-index or separate structure, 
                             but here e.preventDefault() in handler works if button is inside a tag by standard? 
                             Next.js Link wraps children in <a>.
                             Nesting button inside <a> is invalid HTML.
                             Better structure: Div container with onClick for link or just absolute position button?
                             Let's keep it simple: Button is OUTSIDE the Link text area but INSIDE the card visual.
                             Wait, 'Link' simply wraps everything.
                             Solution: Use a div as container, wrap title/content in Link, put button separately.
                          */}
                    </div>

                    <h3 className={styles.title}>{title}</h3>
                    <p className={styles.summary}>{summary}</p>
                </div>
                {imageUrl && <div className={styles.imageWrapper} />}
            </Link>
            <button
                className={styles.bookmarkBtn}
                onClick={handleBookmark}
                title="Bookmark this article"
                style={{ position: 'absolute', right: 0, top: '16px', zIndex: 10 }} // Simple positioning
            >
                {isBookmarked ? '★' : '☆'}
            </button>
        </div>
    );
};

export default ArticleCard;
