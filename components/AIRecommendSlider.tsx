'use client';
import styles from './AIRecommendSlider.module.css';

const RECOMMENDATIONS = [
    { id: 'r1', title: 'Why Transformers are eating the world', tag: 'Deep Dive' },
    { id: 'r2', title: 'Impact of AI on Healthcare 2025', tag: 'Report' },
    { id: 'r3', title: 'Startups to watch in Q4', tag: 'Analysis' },
    { id: 'r4', title: 'Coding with Agents: A Guide', tag: 'Tutorial' },
];

const AIRecommendSlider = () => {
    return (
        <div className={styles.wrapper}>
            <div className={`container`}>
                <div className={styles.header}>
                    <span className={styles.icon}>✨</span>
                    <h3 className={styles.heading}>AI Picks for You</h3>
                </div>
                <div className={styles.slider}>
                    {RECOMMENDATIONS.map(item => (
                        <div key={item.id} className={styles.card}>
                            <span className={styles.tag}>{item.tag}</span>
                            <h4 className={styles.title}>{item.title}</h4>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default AIRecommendSlider;
