'use client';
import { useState } from 'react';
import Link from 'next/link';
import styles from './AuthForm.module.css';

interface AuthFormProps {
    type: 'login' | 'register';
}

const AuthForm = ({ type }: AuthFormProps) => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError('');

        if (!email || !password) {
            setError('Please fill in all fields');
            return;
        }

        if (type === 'login') {
            try {
                // Use local proxy to avoid CORS
                const response = await fetch('/api/auth/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        email: email,
                        password
                    })
                });

                const data = await response.json();

                if (!response.ok) {
                    throw new Error(data.message || 'Login failed');
                }

                console.log('Login successful', data);
                // Save user info for client-side display
                const userIdentifier = data.user?.email || data.email || email;
                localStorage.setItem('user_email', userIdentifier);

                // Redirecting...
                window.location.href = '/';
            } catch (err: any) {
                console.error(err);
                setError(err.message || 'Login failed');
            }
        } else {
            // Register case (legacy, since register page has its own form now)
            // But if used:
            alert('Navigate to /register to create an account');
        }
    };

    return (
        <div className={styles.container}>
            <h2 className={styles.title}>{type === 'login' ? 'Sign In' : 'Create Account'}</h2>
            {error && <div className={styles.error}>{error}</div>}
            <form onSubmit={handleSubmit} className={styles.form}>
                <div className={styles.field}>
                    <label className={styles.label}>Email or Username</label>
                    <input
                        type="text"
                        className={styles.input}
                        value={email}
                        onChange={e => setEmail(e.target.value)}
                    />
                </div>
                <div className={styles.field}>
                    <label className={styles.label}>Password</label>
                    <input
                        type="password"
                        className={styles.input}
                        value={password}
                        onChange={e => setPassword(e.target.value)}
                    />
                </div>
                <button type="submit" className={styles.submitBtn}>
                    {type === 'login' ? 'Sign In' : 'Register'}
                </button>
            </form>
            <div className={styles.footer}>
                {type === 'login' ? (
                    <p>New to AI News? <Link href="/register" className={styles.link}>Register now</Link></p>
                ) : (
                    <p>Already have an account? <Link href="/login" className={styles.link}>Sign in</Link></p>
                )}
            </div>
        </div>
    );
};

export default AuthForm;
