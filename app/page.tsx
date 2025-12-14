import NavBar from '../components/NavBar';
import SearchBar from '../components/SearchBar';
import ArticleList from '../components/ArticleList';
import Pagination from '../components/Pagination';
import AIRecommendSlider from '../components/AIRecommendSlider';
import Footer from '../components/Footer';
import { fetchArticles } from './api/article/api';

export default async function Home(props: { searchParams: Promise<{ page?: string }> }) {
    const searchParams = await props.searchParams;
    const page = parseInt(searchParams?.page || '1', 10);
    const pageSize = 10;

    // Fetch paginated articles directly from API
    const { items: displayedArticles, total: totalItems } = await fetchArticles(page, pageSize);

    const totalPages = Math.ceil(totalItems / pageSize);

    return (
        <main>
            <NavBar />
            <SearchBar />
            <AIRecommendSlider />
            <div className="container">
                <div style={{ padding: '24px 0' }}>
                    {/* Top news layout can be more complex, but keeping it simple for now as per ArticleList specs */}
                    <ArticleList articles={displayedArticles} />
                    <Pagination currentPage={page} totalPages={totalPages} />
                </div>
            </div>
            <Footer />
        </main>
    );
}
