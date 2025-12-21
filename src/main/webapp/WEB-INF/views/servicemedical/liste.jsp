<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services Médicaux - Plateforme Dentaire</title>
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
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

        .header h1 {
            color: #667eea;
            font-size: 2.5rem;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header h1 i {
            font-size: 2.2rem;
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }

        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stat-icon {
            font-size: 2.5rem;
            opacity: 0.9;
        }

        .stat-info h3 {
            font-size: 2rem;
            margin-bottom: 5px;
        }

        .stat-info p {
            font-size: 0.9rem;
            opacity: 0.9;
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
            min-width: 200px;
        }

        .filter-select:focus {
            outline: none;
            border-color: #667eea;
        }

        /* Services Table */
        .services-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        thead th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s;
        }

        tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
        }

        tbody td {
            padding: 18px 15px;
            color: #333;
        }

        .service-name {
            font-weight: 600;
            color: #667eea;
            font-size: 1.05rem;
        }

        .service-type {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .type-consultation { background: #e3f2fd; color: #1976d2; }
        .type-chirurgie { background: #fce4ec; color: #c2185b; }
        .type-orthodontie { background: #f3e5f5; color: #7b1fa2; }
        .type-prothese { background: #fff3e0; color: #f57c00; }
        .type-preventif { background: #e8f5e9; color: #388e3c; }
        .type-urgence { background: #ffebee; color: #d32f2f; }
        .type-autre { background: #f5f5f5; color: #616161; }

        .service-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2ecc71;
        }

        .service-description {
            color: #666;
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
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

        .btn-view {
            background: #667eea;
            color: white;
        }

        .btn-view:hover {
            background: #5568d3;
        }

        .btn-edit {
            background: #3498db;
            color: white;
        }

        .btn-edit:hover {
            background: #2980b9;
        }

        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background: #c0392b;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
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
            .header h1 {
                font-size: 2rem;
            }

            .header-top {
                flex-direction: column;
                align-items: stretch;
            }

            .header-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.9rem;
            }

            thead th,
            tbody td {
                padding: 12px 8px;
            }

            .service-description {
                max-width: 150px;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
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
        <!-- Bouton Modifier - TOUJOURS visible -->
        <a href="${pageContext.request.contextPath}/servicesmedicaux/update?numSM=${service.numSM}" 
           class="btn-action btn-edit">
            <i class="fas fa-edit"></i>
            Modifier
        </a>
        
        <!-- Bouton Supprimer - SEULEMENT si aide-soignant connecté -->
        <c:if test="${not empty sessionScope.aidesoignant}">
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
        // Search and filter functionality
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