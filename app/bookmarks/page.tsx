import NavBar from '../../components/NavBar';
import Footer from '../../components/Footer';
import ArticleList from '../../components/ArticleList';
import { fetchBookmarks } from '../api/bookmark/api';
import { fetchArticleById, Article } from '../api/article/api';
import { redirect } from 'next/navigation';
import styles from './page.module.css';

export const metadata = {
    title: 'My Bookmarks - AI News',
    description: 'Your saved articles',
};

export default async function BookmarksPage() {
    let bookmarks = [];
    try {
        bookmarks = await fetchBookmarks();
    } catch (error: any) {
        if (error.message === 'Unauthorized') {
            redirect('/login');
        }
        // Handle other errors or show empty state
    }

    // Fetch full article details for each bookmark
    // Note: parallelizing these requests is better
    const articlePromises = bookmarks.map((b) => fetchArticleById(b.articleId));
    const articles = (await Promise.all(articlePromises)).filter((a): a is Article => a !== null);

    return (
        <main>
            <NavBar />
            <div className={`container ${styles.container}`}>
                <h1 className={styles.title}>My Bookmarks</h1>
                {articles.length > 0 ? (
                    <ArticleList articles={articles} />
                ) : (
                    <div className={styles.emptyState}>
                        <p>You haven't bookmarked any articles yet.</p>
                        <p>Go explore specific topics or the latest news!</p>
                    </div>
                )}
            </div>
            <Footer />
        </main>
    );
}
