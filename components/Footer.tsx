import styles from './Footer.module.css';

const Footer = () => {
    return (
        <footer className={styles.footer}>
            <div className={`container ${styles.container}`}>
                <div className={styles.brand}>
                    <h2 className={styles.logo}>AI NEWS</h2>
                    <p className={styles.desc}>Trustworthy Artificial Intelligence News & Insights.</p>
                </div>
                <div className={styles.links}>
                    <div className={styles.group}>
                        <h4>Sections</h4>
                        <a href="#">Home</a>
                        <a href="#">Topics</a>
                        <a href="#">Articles</a>
                        <a href="#">Video</a>
                    </div>
                    <div className={styles.group}>
                        <h4>About</h4>
                        <a href="#">Our Story</a>
                        <a href="#">Careers</a>
                        <a href="#">Privacy Policy</a>
                        <a href="#">Terms of Service</a>
                    </div>
                    <div className={styles.group}>
                        <h4>Connect</h4>
                        <a href="#">Twitter</a>
                        <a href="#">LinkedIn</a>
                        <a href="#">Newsletter</a>
                    </div>
                </div>
                <div className={styles.bottom}>
                    &copy; 2025 AI News. All rights reserved.
                </div>
            </div>
        </footer>
    );
};

export default Footer;
