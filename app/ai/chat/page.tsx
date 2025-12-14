import NavBar from '../../../components/NavBar';
import Footer from '../../../components/Footer';
import AIChatBox from '../../../components/AIChatBox';

export default function AIChatPage() {
    return (
        <main>
            <NavBar />
            <div className="container" style={{ padding: '40px 20px', minHeight: '80vh' }}>
                <div style={{ maxWidth: '800px', margin: '0 auto' }}>
                    <div style={{ marginBottom: '30px', textAlign: 'center' }}>
                        <h1 style={{ marginBottom: '10px', fontSize: '2.5rem', fontWeight: '800', letterSpacing: '-0.5px' }}>
                            AI Assistant
                        </h1>
                        <p style={{ color: 'var(--color-text-secondary)', fontSize: '1.1rem' }}>
                            Your personal news assistant. Ask anything.
                        </p>
                    </div>

                    <AIChatBox />
                </div>
            </div>
            <Footer />
        </main>
    );
}
