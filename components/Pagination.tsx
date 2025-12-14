import Link from 'next/link';
import styles from './Pagination.module.css';

interface PaginationProps {
    currentPage: number;
    totalPages: number;
}

const Pagination = ({ currentPage, totalPages }: PaginationProps) => {
    const pages = Array.from({ length: totalPages }, (_, i) => i + 1);

    return (
        <div className={styles.container}>
            {currentPage > 1 ? (
                <Link href={`/?page=${currentPage - 1}`} className={styles.button}>
                    Previous
                </Link>
            ) : (
                <button className={styles.button} disabled>Previous</button>
            )}

            <div className={styles.pages}>
                {pages.map(page => (
                    <Link
                        key={page}
                        href={`/?page=${page}`}
                        className={`${styles.page} ${page === currentPage ? styles.active : ''}`}
                    >
                        {page}
                    </Link>
                ))}
            </div>

            {currentPage < totalPages ? (
                <Link href={`/?page=${currentPage + 1}`} className={styles.button}>
                    Next
                </Link>
            ) : (
                <button className={styles.button} disabled>Next</button>
            )}
        </div>
    );
};

export default Pagination;
