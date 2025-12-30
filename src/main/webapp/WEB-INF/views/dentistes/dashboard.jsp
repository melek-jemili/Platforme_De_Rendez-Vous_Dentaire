<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Dentiste - Dr. ${sessionScope.dentiste.nomD}</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dentiste/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="fas fa-tooth"></i>
            </div>
            <h2>Dental<span style="color: #667eea;">Care</span></h2>
            <p class="specialty">Espace Dentiste</p>
        </div>

        <div class="user-info">
            <div class="user-avatar">
                <i class="fas fa-user-md"></i>
            </div>
            <div class="user-name">Dr. ${sessionScope.dentiste.nomD} ${sessionScope.dentiste.prenomD}</div>
            <div class="user-email">${sessionScope.dentiste.emailD}</div>
        </div>

        <nav class="nav-menu">
            <a href="#overview" class="nav-item active">
                <i class="fas fa-th-large"></i>
                <span>Tableau de bord</span>
            </a>
            <a href="#patients" class="nav-item">
                <i class="fas fa-users"></i>
                <span>Patients</span>
            </a>
            <a href="#rendezvous" class="nav-item">
                <i class="fas fa-calendar-alt"></i>
                <span>Rendez-vous</span>
            </a>
            <a href="#publications" class="nav-item">
                <i class="fas fa-newspaper"></i>
                <span>Publications</span>
            </a>
            <a href="${pageContext.request.contextPath}/dentiste/profile" class="nav-item">
                <i class="fas fa-user-circle"></i>
                <span>Mon Profil</span>
            </a>
        </nav>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Déconnexion
        </a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <div class="dashboard-header">
            <div class="header-title">
                <h1>Bienvenue, Dr. ${sessionScope.dentiste.nomD}</h1>
                <p>
                    <i class="far fa-calendar"></i>
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE dd MMMM yyyy" />
                </p>
            </div>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/rendezvous/add" class="btn btn-primary">
                    <i class="fas fa-calendar-plus"></i>
                    Nouveau RDV
                </a>
                <a href="${pageContext.request.contextPath}/dentiste/profile" class="btn btn-info">
                    <i class="fas fa-user-edit"></i>
                    Mon Profil
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

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Stats Cards -->
        <div class="stats-grid" id="overview">
            <div class="stat-card">
                <div class="stat-icon patients">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3>${patients.size()}</h3>
                    <p>Patients Total</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon rendezvous">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-info">
                    <h3>${rendezvous.size()}</h3>
                    <p>Rendez-vous</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon publications">
                    <i class="fas fa-newspaper"></i>
                </div>
                <div class="stat-info">
                    <h3>${publications.size()}</h3>
                    <p>Publications</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon services">
                    <i class="fas fa-tooth"></i>
                </div>
                <div class="stat-info">
                    <h3>${services.size()}</h3>
                    <p>Services Médicaux</p>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <h2 style="color: white; margin-bottom: 20px; font-size: 1.5rem;">
            <i class="fas fa-bolt"></i> Actions Rapides
        </h2>
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/actesmedicaux" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-notes-medical"></i>
                </div>
                <h3>Créer un Acte Médical</h3>
                <p>Enregistrer un nouvel acte</p>
            </a>

            <a href="${pageContext.request.contextPath}/servicesmedicaux" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-clinic-medical"></i>
                </div>
                <h3>Ajouter un Service</h3>
                <p>Nouveau service médical</p>
            </a>

            <a href="${pageContext.request.contextPath}/publications" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <h3>Publier</h3>
                <p>Nouvelle publication</p>
            </a>
        </div>

        <!-- Patients Section -->
        <div class="section" id="patients">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-users"></i>
                    Mes Patients
                </h2>
            </div>

            <c:choose>
                <c:when test="${empty patients}">
                    <div class="empty-state">
                        <i class="fas fa-user-injured"></i>
                        <p>Aucun patient enregistré</p>
                    </div>
                </c:when>
                <c:otherwise>
  <jsp:useBean id="displayedPatientIds" class="java.util.HashSet" scope="page"/>

<div class="table-wrapper">
    <table>
        <thead>
            <tr>
                <th>Nom & Prénom</th>
                <th>Email</th>
                <th>Recouvrement</th>
                <th>Groupe Sanguin</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="rdv" items="${rendezvous}">
                <c:if test="${displayedPatientIds.add(rdv.patient.idP)}">
                    <tr>
                        <td><strong>${rdv.patient.nomP} ${rdv.patient.prenomP}</strong></td>
                        <td>${rdv.patient.emailP}</td>
                        <td>${rdv.patient.recouvrementP}</td>
                        <td>${rdv.patient.groupeSanguinP}</td>
                    </tr>
                </c:if>
            </c:forEach>
        </tbody>
    </table>
</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Rendez-vous Section -->
        <div class="section" id="rendezvous">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-calendar-alt"></i>
                    Rendez-vous
                </h2>
            </div>

            <c:choose>
                <c:when test="${empty rendezvous}">
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <p>Aucun rendez-vous</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Heure</th>
                                    <th>Patient</th>
                                    <th>Statut</th>
                                    <th>Détails</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="rdv" items="${rendezvous}" begin="0" end="4">
                                    <tr>
                                        <td><fmt:formatDate value="${rdv.dateRv}" pattern="dd/MM/yyyy" /></td>
                                        <td>${rdv.heureRv}</td>
                                        <td><strong>${rdv.patient.nomP} ${rdv.patient.prenomP}</strong></td>
                                        <td>
                                            <span class="status-badge status-${rdv.statutRv}">
                                                ${rdv.statutRv}
                                            </span>
                                        </td>
                                        <td>${rdv.detailsRv}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Publications Section -->
        <div class="section" id="publications">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-newspaper"></i>
                    Publications
                </h2>

            </div>

            <c:choose>
                <c:when test="${empty publications}">
                    <div class="empty-state">
                        <i class="fas fa-newspaper"></i>
                        <p>Aucune publication</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>Titre</th>
                                    <th>Catégorie</th>
                                    <th>Date</th>
                                    <th>Résumé</th>
                                    <th>Lien</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pub" items="${publications}" begin="0" end="4">
                                    <tr>
                                        <td><strong>${pub.titre}</strong></td>
                                        <td>${pub.categorie}</td>
                                        <td><fmt:formatDate value="${pub.dateNP}" pattern="dd/MM/yyyy" /></td>
                                        <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            ${pub.resume}
                                        </td>
                                        <td>
    <a href="${pub.fichier}" target="_blank">
        Voir le fichier
    </a>
</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
   
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', function(e) {
                const href = this.getAttribute('href');
                if (href.startsWith('#')) {
                    e.preventDefault();
                    const target = document.querySelector(href);
                    if (target) {
                        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                    
                 
                    document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
                    this.classList.add('active');
                }
            });
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