'use client';
import { useState, useEffect } from 'react';
import Link from 'next/link';
import styles from './NavBar.module.css';

const NavBar = () => {
    const [userInitial, setUserInitial] = useState<string | null>(null);

    useEffect(() => {
        const email = localStorage.getItem('user_email');
        if (email) {
            setUserInitial(email.substring(0, 2).toUpperCase());
        }
    }, []);


    const handleLogout = () => {
        localStorage.removeItem('user_email');
        setUserInitial(null);
        window.location.href = '/'; // Redirect to home/refresh
    };

    return (
        <header className={styles.header}>
            <div className={`container ${styles.navContainer}`}>
                <Link href="/" className={styles.logo}>
                    AI NEWS
                </Link>
                <nav className={styles.nav}>
                    <Link href="/topics" className={styles.navLink}>Topics</Link>
                    <Link href="/articles" className={styles.navLink}>Articles</Link>
                    <Link href="/ai/chat" className={styles.navLink}>AI Chat</Link>
                    <Link href="/bookmarks" className={styles.navLink}>Bookmarks</Link>
                </nav>
                <div className={styles.userActions}>
                    {userInitial ? (
                        <div className={styles.userMenu}>
                            <div className={styles.userAvatar}>{userInitial}</div>
                            <div className={styles.dropdown}>
                                <button onClick={handleLogout} className={styles.logoutBtn}>
                                    Log Out
                                </button>
                            </div>
                        </div>
                    ) : (
                        <Link href="/login" className={styles.loginBtn}>Sign In</Link>
                    )}
                </div>
            </div>
        </header>
    );
};

export default NavBar;
