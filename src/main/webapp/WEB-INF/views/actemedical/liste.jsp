<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actes Médicaux - Plateforme Dentaire</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/actemedical/liste.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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

        
        const serviceFilterOptions = Array.from(serviceFilter.options);
        const uniqueServices = [...new Set(serviceFilterOptions.map(opt => opt.value))];
        serviceFilter.innerHTML = '<option value="">Tous les services</option>';
        uniqueServices.filter(s => s).forEach(service => {
            const option = document.createElement('option');
            option.value = service;
            option.textContent = service;
            serviceFilter.appendChild(option);
        });

        
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