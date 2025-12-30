<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publications - Plateforme Dentaire</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/publication/liste.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
                 <c:choose>
                        <c:when test="${not empty sessionScope.dentiste}">
                            <a href="${pageContext.request.contextPath}/dentiste/dashboard" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Retour
                            </a>
                        </c:when>
                        <c:when test="${not empty sessionScope.aidesoignant}">
                            <a href="${pageContext.request.contextPath}/aidesoignant/dashboard" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Retour
                            </a>
                        </c:when>
                        
                    </c:choose>
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