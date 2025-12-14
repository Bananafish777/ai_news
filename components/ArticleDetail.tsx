import styles from './ArticleDetail.module.css';

interface ArticleDetailProps {
    title: string;
    author: string;
    date: string;
    content: string; // HTML string or text
    tags: string[];
    imageUrl?: string;
    media?: string[]; // Additional media URLs
}

const ArticleDetail = ({ title, author, date, content, tags, imageUrl, media }: ArticleDetailProps) => {
    return (
        <article className={styles.article}>
            <header className={styles.header}>
                {tags.length > 0 && <span className={styles.tag}>{tags[0]}</span>}
                <h1 className={styles.title}>{title}</h1>
                <div className={styles.meta}>
                    <span className={styles.author}>By {author}</span>
                    <span className={styles.date}>{date}</span>
                </div>
            </header>

            {imageUrl && (
                <div className={styles.imageWrapper}>
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img src={imageUrl} alt={title} className={styles.featuredImage} />
                </div>
            )}

            <div className={styles.content}>
                {/* For safety in a real app we'd use a sanitizer, but here simple rendering */}
                <div dangerouslySetInnerHTML={{ __html: content }} />
            </div>

            {media && media.length > 0 && (
                <div className={styles.mediaGallery}>
                    <h3>Gallery</h3>
                    <div className={styles.galleryGrid}>
                        {media.map((url, index) => (
                            // eslint-disable-next-line @next/next/no-img-element
                            <img key={index} src={url} alt={`Gallery image ${index + 1}`} className={styles.galleryImage} />
                        ))}
                    </div>
                </div>
            )}

            <div className={styles.footer}>
                <div className={styles.tags}>
                    {tags.map(tag => <span key={tag} className={styles.tagItem}>#{tag}</span>)}
                </div>
            </div>
        </article>
    );
};

export default ArticleDetail;
