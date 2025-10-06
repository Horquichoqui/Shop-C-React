import React, { useEffect, useState } from "react";
import api from "./services/api";
import "../App.css";

// Componente Modal para exibir detalhes do produto
function ProductModal({ product, isOpen, onClose }) {
    if (!isOpen || !product) return null;

    const formatarPreco = (preco) => {
        return new Intl.NumberFormat('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        }).format(preco);
    };

    return (
        <div className="modal-overlay" onClick={onClose}>
            <div className="modal-content" onClick={(e) => e.stopPropagation()}>
                <div className="modal-header">
                    <div className="modal-header-left">
                        <button className="modal-reload-image" onClick={() => window.location.reload()} title="Recarregar imagem">
                            🔄
                        </button>
                        <h2>Detalhes do Produto</h2>
                    </div>
                    <button className="modal-close" onClick={onClose}>�</button>
                </div>
                
                <div className="modal-body">
                    <div className="modal-image">
                        <ProductImage productId={product.productId} productName={product.name} isModal={true} />
                    </div>
                    
                    <div className="modal-info">
                        <h3 className="modal-product-name">{product.name}</h3>
                        {product.categoryName && (
                            <p className="modal-category">{product.categoryName}</p>
                        )}
                        
                        <div className="modal-details">
                            <div className="detail-row">
                                <span className="detail-label">Pre�o:</span>
                                <span className="detail-value price">{formatarPreco(product.listPrice)}</span>
                            </div>
                            
                            {product.color && (
                                <div className="detail-row">
                                    <span className="detail-label">Cor:</span>
                                    <span className="detail-value">{product.color}</span>
                                </div>
                            )}
                            
                            {product.size && (
                                <div className="detail-row">
                                    <span className="detail-label">Tamanho:</span>
                                    <span className="detail-value">{product.size}</span>
                                </div>
                            )}
                            
                            {product.weight && (
                                <div className="detail-row">
                                    <span className="detail-label">Peso:</span>
                                    <span className="detail-value">{product.weight} g</span>
                                </div>
                            )}
                            
                            
                            {product.modelName && (
                                <div className="detail-row">
                                    <span className="detail-label">Modelo:</span>
                                    <span className="detail-value">{product.modelName}</span>
                                </div>
                            )}
                            
                            {product.description && (
                                <div className="detail-row full-width">
                                    <span className="detail-label">Descri��o:</span>
                                    <div className="detail-value description" 
                                         dangerouslySetInnerHTML={{ __html: product.description }} />
                                </div>
                            )}
                        </div>
                    </div>
                </div>
                
                <div className="modal-footer">
                    <button className="modal-btn secondary" onClick={onClose}>
                        Fechar
                    </button>
                </div>
            </div>
        </div>
    );
}

// Componente para exibir imagem do produto com fallback
function ProductImage({ productId, productName, isModal = false }) {
    const [showImage, setShowImage] = useState(true);
    const [imageError, setImageError] = useState(false);

    const handleImageError = () => {
        setImageError(true);
        setShowImage(false);
    };

    const handleImageLoad = () => {
        setShowImage(true);
        setImageError(false);
    };

    // Por padrão, mostra placeholder. Só tenta carregar imagem se não houve erro antes
    if (!showImage && !imageError) {
        return (
            <div className="image-placeholder">
                📦
                <button 
                    className="load-image-btn"
                    onClick={() => setShowImage(true)}
                    title={isModal ? "Clique para carregar imagem em alta resolu��o" : "Clique para carregar imagem"}
                >
                    🖼️
                </button>
            </div>
        );
    }

    if (imageError) {
        return (
            <div className="image-placeholder">
                📦
            </div>
        );
    }

    return (
        <img 
            src={`http://localhost:5000/api/Products/${productId}/image`}
            alt={productName}
            className="product-thumbnail"
            onError={handleImageError}
            onLoad={handleImageLoad}
        />
    );
}

function App() {
    const [produtos, setProdutos] = useState([]);
    const [produtosFiltrados, setProdutosFiltrados] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [busca, setBusca] = useState("");
    const [categorias, setCategorias] = useState([]);
    const [categoriaSelecionada, setCategoriaSelecionada] = useState("");
    const [paginaAtual, setPaginaAtual] = useState(1);
    const [totalPaginas, setTotalPaginas] = useState(1);
    const [totalProdutos, setTotalProdutos] = useState(0);
    const [modalAberto, setModalAberto] = useState(false);
    const [produtoDetalhado, setProdutoDetalhado] = useState(null);

    const carregarProdutos = async (pagina = 1, categoria = null) => {
        try {
            setLoading(true);
            const params = new URLSearchParams({
                page: pagina.toString(),
                pageSize: '10'
            });
            
            if (categoria) {
                params.append('categoryId', categoria);
            }

            const response = await api.get(`/Products?${params}`);
            const data = response.data;
            
            setProdutos(data.data);
            setProdutosFiltrados(data.data);
            setTotalPaginas(data.totalPages);
            setTotalProdutos(data.totalRecords);
            setPaginaAtual(data.page);
            setLoading(false);
        } catch (err) {
            console.error("Erro ao buscar produtos:", err);
            setError("Erro ao carregar produtos");
            setLoading(false);
        }
    };

    const carregarCategorias = async () => {
        try {
            const response = await api.get("/Categories");
            setCategorias(response.data);
        } catch (err) {
            console.error("Erro ao buscar categorias:", err);
        }
    };

    useEffect(() => {
        carregarProdutos();
        carregarCategorias();
    }, []);

    // Limpar classe modal-open quando componente for desmontado
    useEffect(() => {
        return () => {
            document.body.classList.remove('modal-open');
        };
    }, []);

    useEffect(() => {
        if (busca.trim() === "") {
            setProdutosFiltrados(produtos);
        } else {
            const filtrados = produtos.filter(produto =>
                produto.name.toLowerCase().includes(busca.toLowerCase()) ||
                (produto.color && produto.color.toLowerCase().includes(busca.toLowerCase()))
            );
            setProdutosFiltrados(filtrados);
        }
    }, [busca, produtos]);

    const handleCategoriaChange = (categoriaId) => {
        setCategoriaSelecionada(categoriaId);
        setPaginaAtual(1);
        carregarProdutos(1, categoriaId || null);
    };

    const handlePaginaChange = (novaPagina) => {
        setPaginaAtual(novaPagina);
        carregarProdutos(novaPagina, categoriaSelecionada || null);
    };

    const abrirModal = async (produtoId) => {
        try {
            const response = await api.get(`/Products/${produtoId}`);
            setProdutoDetalhado(response.data);
            setModalAberto(true);
            document.body.classList.add('modal-open');
        } catch (err) {
            console.error("Erro ao carregar detalhes do produto:", err);
            setError("Erro ao carregar detalhes do produto");
        }
    };

    const fecharModal = () => {
        setModalAberto(false);
        setProdutoDetalhado(null);
        document.body.classList.remove('modal-open');
    };

    const formatarPreco = (preco) => {
        return new Intl.NumberFormat('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        }).format(preco);
    };

    if (loading) {
        return (
            <div className="loading-container">
                <div className="loading-spinner"></div>
                <p>Carregando produtos da SetPar...</p>
            </div>
        );
    }

    if (error) {
        return (
            <div className="error-container">
                <h1>SetPar Store</h1>
                <p className="error-message">{error}</p>
            </div>
        );
    }

    return (
        <div className="app">
            {/* Header */}
            <header className="header">
                <div className="container">
                    <div className="logo">
                        <h1> <img src="https://www.setpar.com.br/app/themes/setpar/dist/setpar-empreendimentos-w.svg" alt="Setpar Loja" height="26" width="126"></img>   SetPar Store</h1>
                        <p>Sua loja de produtos premium</p>
                    </div>
                </div>
            </header>

                {/* Barra de Busca */}
                <section className="search-section">
                    <div className="container">
                        <div className="search-container">
                            <div className="search-filters">
                                <input
                                    type="text"
                                    placeholder="Busque por nome ou cor do produto..."
                                    value={busca}
                                    onChange={(e) => setBusca(e.target.value)}
                                    className="search-input"
                                />
                                <select
                                    value={categoriaSelecionada}
                                    onChange={(e) => handleCategoriaChange(e.target.value)}
                                    className="category-filter"
                                >
                                    <option value="">Todas as categorias</option>
                                    {categorias.map(categoria => (
                                        <option key={categoria.productCategoryId} value={categoria.productCategoryId}>
                                            {categoria.name}
                                        </option>
                                    ))}
                                </select>
                            </div>
                            <div className="search-stats">
                                <span className="product-count">
                                    Página {paginaAtual} de {totalPaginas} - {totalProdutos} produtos no total
                                </span>
                            </div>
                        </div>
                    </div>
                </section>

            {/* Produtos */}
            <main className="main-content">
                <div className="container">
                    {produtosFiltrados.length === 0 ? (
                        <div className="no-results">
                            <h3>Nenhum produto encontrado</h3>
                            <p>Tente buscar por outros termos ou limpe o filtro.</p>
                        </div>
                    ) : (
                        <>
                            <div className="products-grid">
                                {produtosFiltrados.map((produto) => (
                                    <div key={produto.productId} className="product-card">
                                        <div className="product-image">
                                            <ProductImage productId={produto.productId} productName={produto.name} />
                                            {produto.color && (
                                                <div className="color-badge" style={{ backgroundColor: getColorCode(produto.color) }}>
                                                    {produto.color}
                                                </div>
                                            )}
                                        </div>

                                        <div className="product-info">
                                            <h3 className="product-name">{produto.name}</h3>
                                            {produto.color && (
                                                <p className="product-color">Cor: {produto.color}</p>
                                            )}

                                            <div className="product-details">
                                                {produto.productCategoryName && (
                                                    <span className="detail-tag category">Categoria: {produto.productCategoryName}</span>
                                                )}
                                                {produto.productModelName && (
                                                    <span className="detail-tag model">Modelo: {produto.productModelName}</span>
                                                )}
                                                {produto.thumbnailPhotoFileName && (
                                                    <span className="detail-tag">Imagem: {produto.thumbnailPhotoFileName}</span>
                                                )}
                                            </div>

                                            <div className="product-price">
                                                {formatarPreco(produto.listPrice)}
                                            </div>

                                            <button 
                                                className="view-details-btn"
                                                onClick={() => abrirModal(produto.productId)}
                                            >
                                                Ver Detalhes
                                            </button>
                                        </div>
                                    </div>
                                ))}
                            </div>
                            
                            {/* Paginação */}
                            {totalPaginas > 1 && (
                                <div className="pagination">
                                    <button 
                                        onClick={() => handlePaginaChange(paginaAtual - 1)}
                                        disabled={paginaAtual === 1}
                                        className="pagination-btn"
                                    >
                                        Anterior
                                    </button>
                                    
                                    {Array.from({ length: Math.min(5, totalPaginas) }, (_, i) => {
                                        const pagina = i + 1;
                                        return (
                                            <button
                                                key={pagina}
                                                onClick={() => handlePaginaChange(pagina)}
                                                className={`pagination-btn ${pagina === paginaAtual ? 'active' : ''}`}
                                            >
                                                {pagina}
                                            </button>
                                        );
                                    })}
                                    
                                    <button 
                                        onClick={() => handlePaginaChange(paginaAtual + 1)}
                                        disabled={paginaAtual === totalPaginas}
                                        className="pagination-btn"
                                    >
                                        Próxima
                                    </button>
                                </div>
                            )}
                        </>
                    )}
                </div>
            </main>

            {/* Footer */}
            <footer className="footer">
                <div className="container">
                    <p>&copy; 2025 SetPar Store - Todos os direitos reservados</p>
                </div>
            </footer>

            {/* Modal */}
            <ProductModal 
                product={produtoDetalhado}
                isOpen={modalAberto}
                onClose={fecharModal}
            />
        </div>
    );
}

function getColorCode(colorName) {
    const colors = {
        'black': '#000000',
        'white': '#ffffff',
        'red': '#ff0000',
        'blue': '#0000ff',
        'green': '#008000',
        'yellow': '#ffff00',
        'silver': '#c0c0c0',
        'multi': '#ff6b6b'
    };
    return colors[colorName.toLowerCase()] || '#e0e0e0';
}

export default App;
