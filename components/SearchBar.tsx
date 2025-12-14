'use client';
import styles from './SearchBar.module.css';

const SearchBar = () => {
    return (
        <div className={`container ${styles.wrapper}`}>
            <div className={styles.searchContainer}>
                <input
                    type="text"
                    placeholder="Search for news, topics, or sources..."
                    className={styles.input}
                />
                <button className={styles.searchButton}>Search</button>
            </div>
            <div className={styles.filters}>
                <span className={styles.filterTitle}>Trending:</span>
                <button className={styles.filterTag}>#AGI</button>
                <button className={styles.filterTag}>#MachineLearning</button>
                <button className={styles.filterTag}>#Robotics</button>
                <button className={styles.filterTag}>#Ethics</button>
            </div>
        </div>
    );
};

export default SearchBar;
