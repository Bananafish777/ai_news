import ArticleCard from './ArticleCard';
import styles from './ArticleList.module.css';
import { Article } from '../app/api/article/api';

interface ArticleListProps {
    articles: Article[];
}

const ArticleList = ({ articles }: ArticleListProps) => {
    const ARTICLES = articles.map(article => ({
        id: article.id.toString(),
        title: article.title,
        summary: article.author ? `By ${article.author}` : 'Read full article', // Fallback for summary
        source: article.source.name,
        time: new Date(article.update_time).toLocaleDateString(undefined, {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        }),
        imageUrl: undefined // API does not return image in list view
    }));

    return (
        <div className={styles.list}>
            <h2 className={styles.sectionTitle}>Latest News</h2>
            {ARTICLES.map(article => (
                <ArticleCard key={article.id} {...article} />
            ))}
        </div>
    );
};

export default ArticleList;
