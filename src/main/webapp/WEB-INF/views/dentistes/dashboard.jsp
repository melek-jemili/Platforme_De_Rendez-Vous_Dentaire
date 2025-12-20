<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Dentiste - Dr. ${sessionScope.dentiste.nomD}</title>
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
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 30px 0;
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 5px 0 20px rgba(0,0,0,0.3);
        }

        .logo-section {
            text-align: center;
            padding: 0 20px 30px;
            border-bottom: 2px solid rgba(255,255,255,0.1);
        }

        .logo-icon {
            font-size: 3.5rem;
            color: #667eea;
            margin-bottom: 15px;
        }

        .logo-section h2 {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }

        .logo-section .specialty {
            font-size: 0.9rem;
            opacity: 0.7;
        }

        .user-info {
            padding: 25px 20px;
            text-align: center;
            background: rgba(255,255,255,0.05);
            margin: 20px 0;
        }

        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 2rem;
            border: 3px solid white;
        }

        .user-name {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .user-email {
            font-size: 0.85rem;
            opacity: 0.7;
        }

        .nav-menu {
            padding: 20px 0;
        }

        .nav-item {
            padding: 15px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .nav-item:hover {
            background: rgba(255,255,255,0.1);
            border-left-color: #667eea;
            padding-left: 30px;
        }

        .nav-item i {
            font-size: 1.2rem;
            width: 25px;
        }

        .nav-item.active {
            background: rgba(102, 126, 234, 0.2);
            border-left-color: #667eea;
        }

        .logout-btn {
            position: absolute;
            bottom: 20px;
            left: 20px;
            right: 20px;
            padding: 15px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .logout-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }

        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 30px;
        }

        /* Header */
        .dashboard-header {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-title h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 5px;
        }

        .header-title p {
            color: #666;
            font-size: 0.95rem;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: #2ecc71;
            color: white;
        }

        .btn-success:hover {
            background: #27ae60;
            transform: translateY(-2px);
        }

        .btn-info {
            background: #3498db;
            color: white;
        }

        .btn-info:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .stat-icon {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
        }

        .stat-icon.patients {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stat-icon.rendezvous {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .stat-icon.publications {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .stat-icon.services {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .stat-info h3 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: #666;
            font-size: 0.9rem;
        }

        /* Section Container */
        .section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .section-title {
            font-size: 1.5rem;
            color: #333;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: #667eea;
        }

        /* Table Styles */
        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8f9fa;
        }

        thead th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s;
        }

        tbody tr:hover {
            background: #f8f9fa;
        }

        tbody td {
            padding: 15px;
            color: #555;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-confirme {
            background: #d4edda;
            color: #155724;
        }

        .status-en-attente {
            background: #fff3cd;
            color: #856404;
        }

        .status-annule {
            background: #f8d7da;
            color: #721c24;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: #999;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state p {
            font-size: 1.1rem;
        }

        /* Alerts */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
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

        /* Quick Actions Grid */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .quick-action-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .quick-action-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 15px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
        }

        .quick-action-card:nth-child(1) .quick-action-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .quick-action-card:nth-child(2) .quick-action-icon {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .quick-action-card:nth-child(3) .quick-action-icon {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .quick-action-card h3 {
            color: #333;
            font-size: 1rem;
            margin-bottom: 5px;
        }

        .quick-action-card p {
            color: #666;
            font-size: 0.85rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-280px);
                transition: transform 0.3s;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-header {
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
        }
    </style>
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

        <a href="${pageContext.request.contextPath}/" class="logout-btn">
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
            <a href="${pageContext.request.contextPath}/actesmedicaux/add" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-notes-medical"></i>
                </div>
                <h3>Créer un Acte Médical</h3>
                <p>Enregistrer un nouvel acte</p>
            </a>

            <a href="${pageContext.request.contextPath}/servicesmedicaux/add" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-clinic-medical"></i>
                </div>
                <h3>Ajouter un Service</h3>
                <p>Nouveau service médical</p>
            </a>

            <a href="${pageContext.request.contextPath}/publications/add" class="quick-action-card">
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
        // Smooth scrolling for navigation
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', function(e) {
                const href = this.getAttribute('href');
                if (href.startsWith('#')) {
                    e.preventDefault();
                    const target = document.querySelector(href);
                    if (target) {
                        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                    
                    // Update active state
                    document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
                    this.classList.add('active');
                }
            });
        });

        // Auto-hide alerts
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