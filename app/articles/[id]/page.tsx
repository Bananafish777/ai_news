import { fetchArticleById } from '../../api/article/api';
import ArticleDetail from '../../../components/ArticleDetail';
import NavBar from '../../../components/NavBar';
import Footer from '../../../components/Footer';
import AIChatBox from '../../../components/AIChatBox';
import { notFound, redirect } from 'next/navigation';
import type { Metadata } from 'next';
import styles from '../../../components/ArticlePage.module.css';

interface ArticlePageProps {
    params: Promise<{
        id: string;
    }>;
}

export async function generateMetadata({ params }: ArticlePageProps): Promise<Metadata> {
    const resolvedParams = await params;
    const id = parseInt(resolvedParams.id);
    let article;
    try {
        article = await fetchArticleById(id);
    } catch (e) {
        return {
            title: 'AI News',
            description: 'Login to view this article'
        };
    }

    if (!article) {
        return {
            title: 'Article Not Found',
        };
    }

    return {
        title: article.title,
        description: article.content?.[0]?.content.substring(0, 160) || 'Article detail',
    };
}

export default async function ArticlePage({ params }: ArticlePageProps) {
    const resolvedParams = await params;
    const id = parseInt(resolvedParams.id);

    if (isNaN(id)) {
        notFound();
    }

    let article;
    try {
        article = await fetchArticleById(id);
    } catch (error: any) {
        if (error.message === 'Unauthorized') {
            redirect('/login');
        }
        console.error(error);
        article = null;
    }

    if (!article) {
        notFound();
    }

    // Transform API data to Component props
    // Assuming content parts should be joined
    const content = article.content?.map((c) => c.content).join('\n') || 'No content available.';

    // safe handling of tags/topics
    const tags = Array.isArray(article.topic)
        ? article.topic.map((t: any) => typeof t === 'string' ? t : t?.name || '')
        : [];

    const mediaUrls = article.media?.map(m => m.url) || [];
    const featuredImage = mediaUrls.length > 0 ? mediaUrls[0] : undefined;

    const formattedDate = article.update_time
        ? new Date(article.update_time).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        })
        : 'Recent';

    return (
        <main>
            <NavBar />
            <div className={`container ${styles.pageContainer}`}>
                <div className={styles.grid}>
                    <div className={styles.mainContent}>
                        <ArticleDetail
                            title={article.title}
                            author={article.author || article.source?.name || 'Unknown Author'}
                            date={formattedDate}
                            content={content}
                            tags={tags.filter(Boolean)}
                            imageUrl={featuredImage}
                            media={mediaUrls}
                        />
                    </div>
                    <aside className={styles.sidebar}>
                        <AIChatBox context={content} />
                    </aside>
                </div>
            </div>
            <Footer />
        </main>
    );
}
