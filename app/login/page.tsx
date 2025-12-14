import NavBar from '../../components/NavBar';
import AuthForm from '../../components/AuthForm';
import Footer from '../../components/Footer';

export default function LoginPage() {
    return (
        <main>
            <NavBar />
            <div className="container" style={{ minHeight: '60vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <AuthForm type="login" />
            </div>
            <Footer />
        </main>
    );
}
