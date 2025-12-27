<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publications - Plateforme Dentaire</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header */
        .header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-left {
            flex: 1;
        }

        .header h1 {
            color: #667eea;
            font-size: 2.5rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header h1 i {
            font-size: 2.2rem;
        }

        .header p {
            color: #666;
            font-size: 1.1rem;
        }

        .stats {
            display: flex;
            gap: 20px;
            margin-top: 15px;
        }

        .stat-item {
            background: #f8f9fa;
            padding: 10px 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .stat-item i {
            color: #667eea;
            font-size: 1.5rem;
        }

        .stat-item strong {
            color: #333;
            font-size: 1.2rem;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        /* Search and Filter */
        .controls {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 12px 45px 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .filter-select {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .filter-select:focus {
            outline: none;
            border-color: #667eea;
        }

        /* Publications Grid */
        .publications-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .publication-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s;
            display: flex;
            flex-direction: column;
        }

        .publication-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .publication-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 4rem;
        }

        .publication-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .publication-content {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .publication-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
            gap: 10px;
        }

        .publication-category {
            background: #667eea;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            white-space: nowrap;
        }

        .publication-date {
            color: #999;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .publication-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 12px;
            font-weight: 600;
            line-height: 1.4;
        }

        .publication-resume {
            color: #666;
            line-height: 1.6;
            margin-bottom: 15px;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .publication-footer {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
        }

        .btn-small {
            flex: 1;
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }
        .btn-action {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }
        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        .btn-view {
            background: #667eea;
            color: white;
        }

        .btn-view:hover {
            background: #5568d3;
        }

        .btn-download {
            background: #2ecc71;
            color: white;
        }

        .btn-download:hover {
            background: #27ae60;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .empty-state i {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            color: #666;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #999;
            margin-bottom: 20px;
        }

        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
        }

        .alert-error {
            background: #f8d7da;
            border-left: 4px solid #dc3545;
            color: #721c24;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                text-align: center;
            }

            .header h1 {
                font-size: 2rem;
                justify-content: center;
            }

            .header-actions {
                width: 100%;
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .publications-grid {
                grid-template-columns: 1fr;
            }

            .stats {
                flex-direction: column;
                width: 100%;
            }

            .stat-item {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="header-left">
                <h1>
                    <i class="fas fa-newspaper"></i>
                    Publications
                </h1>
                <p>Bibliothèque des publications dentaires</p>
                <div class="stats">
                    <div class="stat-item">
                        <i class="fas fa-book"></i>
                        <span><strong>${totalPublications}</strong> publications</span>
                    </div>
                </div>
            </div>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/publications/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Nouvelle Publication
                </a>
                <a href="${pageContext.request.contextPath}/aidesoignant/dashboard" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Retour
                </a>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Search and Filter -->
        <div class="controls">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Rechercher une publication...">
                <i class="fas fa-search"></i>
            </div>
            <select class="filter-select" id="categoryFilter">
                <option value="">Toutes les catégories</option>
                <option value="Recherche">Recherche</option>
                <option value="Article">Article</option>
                <option value="Étude de cas">Étude de cas</option>
                <option value="Guide pratique">Guide pratique</option>
                <option value="Revue">Revue</option>
                <option value="Formation">Formation</option>
                <option value="Actualité">Actualité</option>
                <option value="Autre">Autre</option>
            </select>
        </div>

        <!-- Publications Grid -->
        <c:choose>
            <c:when test="${empty publications}">
                <div class="empty-state">
                    <i class="fas fa-folder-open"></i>
                    <h3>Aucune publication disponible</h3>
                    <p>Commencez par ajouter votre première publication</p>
                    <a href="${pageContext.request.contextPath}/publications/add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Ajouter une Publication
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="publications-grid" id="publicationsGrid">
                    <c:forEach var="pub" items="${publications}">
                        <div class="publication-card" data-category="${pub.categorie}" data-title="${pub.titre}">
                            <!-- Image -->
                            <div class="publication-image">
                                <c:choose>
                                    <c:when test="${not empty pub.affiche}">
                                        <img src="${pub.affiche}" alt="${pub.titre}">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-file-alt"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Content -->
                            <div class="publication-content">
                                <div class="publication-header">
                                    <span class="publication-category">${pub.categorie}</span>
                                    <span class="publication-date">
                                        <i class="far fa-calendar"></i>
                                        <fmt:formatDate value="${pub.dateNP}" pattern="dd/MM/yyyy" />
                                    </span>
                                </div>

                                <h3 class="publication-title">${pub.titre}</h3>

                                <p class="publication-resume">
                                    <c:choose>
                                        <c:when test="${not empty pub.resume}">
                                            ${pub.resume}
                                        </c:when>
                                        <c:otherwise>
                                            Aucun résumé disponible pour cette publication.
                                        </c:otherwise>
                                    </c:choose>
                                </p>

                                <div class="publication-footer">
                                    <c:if test="${not empty pub.fichier}">
                                        <a href="${pub.fichier}" target="_blank" class="btn-small btn-download">
                                            <i class="fas fa-download"></i>
                                            Télécharger
                                        </a>
                                    </c:if>
                                    <form action="${pageContext.request.contextPath}/publication/delete" method="get" style="display:inline;"
      onsubmit="return confirm('Voulez-vous vraiment supprimer cette publication ?');">
    <input type="hidden" name="idPub" value="${pub.idPub}">
    <button type="submit" class="btn-action btn-delete">
        <i class="fas fa-trash-alt"></i> Supprimer
    </button>
</form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const categoryFilter = document.getElementById('categoryFilter');
        const cards = document.querySelectorAll('.publication-card');

        function filterPublications() {
            const searchTerm = searchInput.value.toLowerCase();
            const selectedCategory = categoryFilter.value;

            cards.forEach(card => {
                const title = card.dataset.title.toLowerCase();
                const category = card.dataset.category;

                const matchesSearch = title.includes(searchTerm);
                const matchesCategory = !selectedCategory || category === selectedCategory;

                if (matchesSearch && matchesCategory) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        searchInput.addEventListener('input', filterPublications);
        categoryFilter.addEventListener('change', filterPublications);

        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);
    </script>
</body>
</html>