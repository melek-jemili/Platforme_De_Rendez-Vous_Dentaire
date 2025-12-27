<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actes Médicaux - Plateforme Dentaire</title>
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
            flex-wrap: wrap;
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

        /* Actes Table */
        .actes-container {
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

        .patient-info {
            font-weight: 600;
            color: #667eea;
        }

        .service-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            background: #e3f2fd;
            color: #1976d2;
        }

        .price {
            font-size: 1.2rem;
            font-weight: 700;
            color: #2ecc71;
        }

        .date-info {
            color: #666;
            font-size: 0.9rem;
        }

        .description-cell {
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #666;
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

            .description-cell {
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
                    <i class="fas fa-stethoscope"></i>
                    Actes Médicaux
                </h1>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/actesmedicaux/add" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Nouvel Acte
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

            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-file-medical stat-icon"></i>
                    <div class="stat-info">
                        <h3>${actes.size()}</h3>
                        <p>Actes enregistrés</p>
                    </div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-euro-sign stat-icon"></i>
                    <div class="stat-info">
                        <h3>
                            <c:set var="total" value="0" />
                            <c:forEach var="acte" items="${actes}">
                                <c:set var="total" value="${total + acte.tarifAM}" />
                            </c:forEach>
                            <fmt:formatNumber value="${total}" pattern="#,##0.00"/>
                        </h3>
                        <p>Total DT</p>
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
                <input type="text" id="searchInput" placeholder="Rechercher par patient, service...">
                <i class="fas fa-search"></i>
            </div>
            <select class="filter-select" id="serviceFilter">
                <option value="">Tous les services</option>
                <c:forEach var="acte" items="${actes}">
                    <c:if test="${not empty acte.serviceMedical}">
                        <option value="${acte.serviceMedical.nomSM}">${acte.serviceMedical.nomSM}</option>
                    </c:if>
                </c:forEach>
            </select>
        </div>

        <!-- Actes Table -->
        <div class="actes-container">
            <c:choose>
                <c:when test="${empty actes}">
                    <div class="empty-state">
                        <i class="fas fa-file-medical"></i>
                        <h3>Aucun acte médical enregistré</h3>
                        <p>Commencez par ajouter votre premier acte médical</p>
                        <a href="${pageContext.request.contextPath}/actesmedicaux/add" class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Ajouter un Acte
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table id="actesTable">
                            <thead>
                                <tr>
                                    <th>N°</th>
                                    <th>Patient</th>
                                    <th>Dentiste</th>
                                    <th>Service</th>
                                    <th>Date RDV</th>
                                    <th>Description</th>
                                    <th>Tarif</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="acte" items="${actes}">
                                    <tr data-patient="${acte.rendezvous.patient.nomP} ${acte.rendezvous.patient.prenomP}"
                                        data-service="${acte.serviceMedical.nomSM}">
                                        <td>${acte.idAM}</td>
                                        <td>
                                            <div class="patient-info">
                                                ${acte.rendezvous.patient.nomP} ${acte.rendezvous.patient.prenomP}
                                            </div>
                                        </td>
                                        <td>
                                            Dr. ${acte.rendezvous.dentiste.nomD} ${acte.rendezvous.dentiste.prenomD}
                                        </td>
                                        <td>
                                            <span class="service-badge">
                                                ${acte.serviceMedical.nomSM}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="date-info">
                                                <fmt:formatDate value="${acte.rendezvous.dateRv}" pattern="dd/MM/yyyy"/>
                                                <br>
                                                <fmt:formatDate value="${acte.rendezvous.dateRv}" pattern="HH:mm"/>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="description-cell" title="${acte.descriptionAM}">
                                                <c:choose>
                                                    <c:when test="${not empty acte.descriptionAM}">
                                                        ${acte.descriptionAM}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Aucune description
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="price">
                                                <fmt:formatNumber value="${acte.tarifAM}" pattern="#,##0.00"/> DT
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/actesmedicaux/update?idAM=${acte.idAM}" 
                                                   class="btn-action btn-edit">
                                                    <i class="fas fa-edit"></i>
                                                    Modifier
                                                </a>
                                               <form action="${pageContext.request.contextPath}/actesmedicaux/delete" method="get" style="display:inline;"
      onsubmit="return confirm('Voulez-vous vraiment supprimer cet acte médical ?');">
    <input type="hidden" name="idAM" value="${acte.idAM}">
    <button type="submit" class="btn-action btn-delete">
        <i class="fas fa-trash-alt"></i> Supprimer
    </button>
</form>
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
        const serviceFilter = document.getElementById('serviceFilter');
        const tableRows = document.querySelectorAll('#actesTable tbody tr');

        function filterActes() {
            const searchTerm = searchInput.value.toLowerCase();
            const selectedService = serviceFilter.value;

            tableRows.forEach(row => {
                const patient = row.dataset.patient.toLowerCase();
                const service = row.dataset.service;

                const matchesSearch = patient.includes(searchTerm) || service.toLowerCase().includes(searchTerm);
                const matchesService = !selectedService || service === selectedService;

                if (matchesSearch && matchesService) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        searchInput.addEventListener('input', filterActes);
        serviceFilter.addEventListener('change', filterActes);

        // Remove duplicate options in service filter
        const serviceFilterOptions = Array.from(serviceFilter.options);
        const uniqueServices = [...new Set(serviceFilterOptions.map(opt => opt.value))];
        serviceFilter.innerHTML = '<option value="">Tous les services</option>';
        uniqueServices.filter(s => s).forEach(service => {
            const option = document.createElement('option');
            option.value = service;
            option.textContent = service;
            serviceFilter.appendChild(option);
        });

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