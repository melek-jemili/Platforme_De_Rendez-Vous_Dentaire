<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services Médicaux - Plateforme Dentaire</title>
       <link rel="stylesheet" href="${pageContext.request.contextPath}/css/servicemedical/listD.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="header-top">
                <h1>
                    <i class="fas fa-tooth"></i>
                    Services Médicaux
                </h1>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/servicesmedicaux/add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Ajouter un Service
                    </a>
                    <a href="${pageContext.request.contextPath}/dentiste/dashboard" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Retour
                    </a>
                </div>
            </div>

            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-list stat-icon"></i>
                    <div class="stat-info">
                        <h3>${services.size()}</h3>
                        <p>Services disponibles</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Search and Filter -->
        <div class="controls">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Rechercher un service...">
                <i class="fas fa-search"></i>
            </div>
            <select class="filter-select" id="typeFilter">
                <option value="">Tous les types</option>
                <option value="Consultation">Consultation</option>
                <option value="Chirurgie">Chirurgie</option>
                <option value="Orthodontie">Orthodontie</option>
                <option value="Prothèse">Prothèse</option>
                <option value="Préventif">Préventif</option>
                <option value="Urgence">Urgence</option>
                <option value="Autre">Autre</option>
            </select>
        </div>

        <!-- Services Table -->
        <div class="services-container">
            <c:choose>
                <c:when test="${empty services}">
                    <div class="empty-state">
                        <i class="fas fa-clinic-medical"></i>
                        <h3>Aucun service médical disponible</h3>
                        <p>Commencez par ajouter votre premier service</p>
                        <a href="${pageContext.request.contextPath}/servicesmedicaux/add" class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Ajouter un Service
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table id="servicesTable">
                            <thead>
                                <tr>
                                    <th>N°</th>
                                    <th>Nom du Service</th>
                                    <th>Type</th>
                                    <th>Description</th>
                                    <th>Tarif</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="service" items="${services}">
                                    <tr data-type="${service.typeSM}" data-name="${service.nomSM}">
                                        <td>${service.numSM}</td>
                                        <td>
                                            <span class="service-name">${service.nomSM}</span>
                                        </td>
                                        <td>
                                            <c:set var="typeClass" value="type-autre" />
                                            <c:choose>
                                                <c:when test="${service.typeSM == 'Consultation'}">
                                                    <c:set var="typeClass" value="type-consultation" />
                                                </c:when>
                                                <c:when test="${service.typeSM == 'Chirurgie'}">
                                                    <c:set var="typeClass" value="type-chirurgie" />
                                                </c:when>
                                                <c:when test="${service.typeSM == 'Orthodontie'}">
                                                    <c:set var="typeClass" value="type-orthodontie" />
                                                </c:when>
                                                <c:when test="${service.typeSM == 'Prothèse'}">
                                                    <c:set var="typeClass" value="type-prothese" />
                                                </c:when>
                                                <c:when test="${service.typeSM == 'Préventif'}">
                                                    <c:set var="typeClass" value="type-preventif" />
                                                </c:when>
                                                <c:when test="${service.typeSM == 'Urgence'}">
                                                    <c:set var="typeClass" value="type-urgence" />
                                                </c:when>
                                            </c:choose>
                                            <span class="service-type ${typeClass}">
                                                ${service.typeSM}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="service-description" title="${service.descriptionSM}">
                                                <c:choose>
                                                    <c:when test="${not empty service.descriptionSM}">
                                                        ${service.descriptionSM}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Aucune description
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="service-price">
                                                <fmt:formatNumber value="${service.tarifSM}" pattern="#,##0.00" /> DT
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/servicesmedicaux/view?numSM=${service.numSM}" 
                                                   class="btn-action btn-view">
                                                    <i class="fas fa-eye"></i>
                                                    Détails
                                                </a>
                                                <c:if test="${not empty sessionScope.aidesoignant}">
                                                    <a href="${pageContext.request.contextPath}/servicesmedicaux/update?numSM=${service.numSM}" 
                                                       class="btn-action btn-edit">
                                                        <i class="fas fa-edit"></i>
                                                        Modifier
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/servicesmedicaux/delete" 
                                                          method="get" style="display:inline;"
                                                          onsubmit="return confirm('Voulez-vous vraiment supprimer ce service ?');">
                                                        <input type="hidden" name="numSM" value="${service.numSM}">
                                                        <button type="submit" class="btn-action btn-delete">
                                                            <i class="fas fa-trash-alt"></i>
                                                            Supprimer
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
     
        const searchInput = document.getElementById('searchInput');
        const typeFilter = document.getElementById('typeFilter');
        const tableRows = document.querySelectorAll('#servicesTable tbody tr');

        function filterServices() {
            const searchTerm = searchInput.value.toLowerCase();
            const selectedType = typeFilter.value;

            tableRows.forEach(row => {
                const name = row.dataset.name.toLowerCase();
                const type = row.dataset.type;

                const matchesSearch = name.includes(searchTerm);
                const matchesType = !selectedType || type === selectedType;

                if (matchesSearch && matchesType) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        searchInput.addEventListener('input', filterServices);
        typeFilter.addEventListener('change', filterServices);

        
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