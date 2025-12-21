<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Aide-Soignant - ${sessionScope.aidesoignant.nom}</title>
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
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .logo-section h2 {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }

        .logo-section .specialty {
            font-size: 0.9rem;
            opacity: 0.7;
            background: rgba(102, 126, 234, 0.2);
            padding: 5px 15px;
            border-radius: 20px;
            display: inline-block;
            margin-top: 10px;
        }

        .user-info {
            padding: 25px 20px;
            text-align: center;
            background: rgba(255,255,255,0.05);
            margin: 20px 0;
            border-top: 1px solid rgba(255,255,255,0.1);
            border-bottom: 1px solid rgba(255,255,255,0.1);
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
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-name {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .user-role {
            font-size: 0.85rem;
            opacity: 0.8;
            background: rgba(102, 126, 234, 0.3);
            padding: 3px 10px;
            border-radius: 12px;
            display: inline-block;
            margin-bottom: 8px;
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
            position: relative;
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

        .nav-item.active::after {
            content: '';
            position: absolute;
            right: 20px;
            width: 8px;
            height: 8px;
            background: #667eea;
            border-radius: 50%;
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
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 30px;
            min-height: 100vh;
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

        .header-title h1 i {
            color: #667eea;
            margin-right: 10px;
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
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.4);
        }

        .btn-info {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
        }

        .btn-info:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.4);
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
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: rgba(102, 126, 234, 0.05);
            border-radius: 50%;
            transform: translate(30%, -30%);
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
            position: relative;
            z-index: 1;
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

        .stat-info {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .stat-info h3 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 5px;
            font-weight: 700;
        }

        .stat-info p {
            color: #666;
            font-size: 0.9rem;
        }

        .stat-trend {
            font-size: 0.75rem;
            margin-top: 5px;
        }

        .stat-trend.up {
            color: #27ae60;
        }

        .stat-trend.down {
            color: #e74c3c;
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
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
        }

        thead th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        thead th i {
            margin-right: 5px;
            color: #667eea;
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
            padding: 15px;
            color: #555;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-badge.status-Confirmé,
        .status-badge.status-confirme {
            background: #d4edda;
            color: #155724;
        }

        .status-badge.status-En-attente,
        .status-badge.status-en-attente {
            background: #fff3cd;
            color: #856404;
        }

        .status-badge.status-Annulé,
        .status-badge.status-annule {
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
            margin-bottom: 20px;
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
            position: relative;
            overflow: hidden;
        }

        .quick-action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transform: scaleX(0);
            transition: transform 0.3s;
        }

        .quick-action-card:hover::before {
            transform: scaleX(1);
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
            transition: all 0.3s;
        }

        .quick-action-card:hover .quick-action-icon {
            transform: scale(1.1) rotate(5deg);
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

        .section-subtitle {
            color: white;
            margin-bottom: 20px;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Patients Unique Table */
        .patient-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            margin-right: 10px;
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
            <p class="specialty">Espace Aide-Soignant</p>
        </div>

        <div class="user-info">
            <div class="user-avatar">
                <c:choose>
                    <c:when test="${not empty sessionScope.aidesoignant.photoP}">
                        <img src="${pageContext.request.contextPath}/${sessionScope.aidesoignant.photoP}" alt="Photo">
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user-nurse"></i>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-role">Aide-Soignant</div>
            <div class="user-name">${sessionScope.aidesoignant.nom} ${sessionScope.aidesoignant.prenom}</div>
            <div class="user-email">${sessionScope.aidesoignant.emailP}</div>
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
            <a href="${pageContext.request.contextPath}/aidesoignants/profile" class="nav-item">
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
                <h1>
                    <i class="fas fa-hand-holding-medical"></i>
                    Bienvenue, ${sessionScope.aidesoignant.nom}
                </h1>
                <p>
                    <i class="far fa-calendar"></i>
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE dd MMMM yyyy" />
                </p>
            </div>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/rendezvous/add" class="btn btn-success">
                    <i class="fas fa-calendar-plus"></i>
                    Nouveau RDV
                </a>
                <a href="${pageContext.request.contextPath}/aidesoignants/profile" class="btn btn-info">
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
        <h2 class="section-subtitle">
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
                    Patients Récents
                </h2>
                <a href="${pageContext.request.contextPath}/patients/list" class="btn btn-primary">
                    <i class="fas fa-list"></i>
                    Tous les patients
                </a>
            </div>

            <c:choose>
                <c:when test="${empty rendezvous}">
                    <div class="empty-state">
                        <i class="fas fa-user-times"></i>
                        <p>Aucun patient enregistré</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Créer un Set pour éviter les doublons -->
                    <jsp:useBean id="displayedPatientIds" class="java.util.HashSet" scope="page"/>
                    
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th><i class="fas fa-user"></i> Nom & Prénom</th>
                                    <th><i class="fas fa-envelope"></i> Email</th>
                                    <th><i class="fas fa-shield-alt"></i> Recouvrement</th>
                                    <th><i class="fas fa-tint"></i> Groupe Sanguin</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="rdv" items="${rendezvous}">
                                    <c:if test="${displayedPatientIds.add(rdv.patient.idP) && displayedPatientIds.size() <= 5}">
                                        <tr>
                                            <td>
                                                <div style="display: flex; align-items: center;">
                                                    <div class="patient-avatar">
                                                        ${fn:substring(rdv.patient.prenomP, 0, 1)}${fn:substring(rdv.patient.nomP, 0, 1)}
                                                    </div>
                                                    <strong>${rdv.patient.nomP} ${rdv.patient.prenomP}</strong>
                                                </div>
                                            </td>
                                            <td>${rdv.patient.emailP}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty rdv.patient.recouvrementP}">
                                                        <span style="color: #27ae60;">
                                                            <i class="fas fa-check-circle"></i> ${rdv.patient.recouvrementP}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #999;">Non renseigné</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty rdv.patient.groupeSanguinP}">
                                                        <strong style="color: #e74c3c;">${rdv.patient.groupeSanguinP}</strong>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #999;">Non renseigné</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
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
                    Rendez-vous Récents
                </h2>
                <a href="${pageContext.request.contextPath}/rendezvous/list" class="btn btn-primary">
                    <i class="fas fa-list"></i>
                    Tous les rendez-vous
                </a>
            </div>

            <c:choose>
                <c:when test="${empty rendezvous}">
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <p>Aucun rendez-vous programmé</p>
                        <a href="${pageContext.request.contextPath}/rendezvous/add" class="btn btn-primary" style="margin-top: 20px;">
                            <i class="fas fa-calendar-plus"></i>
                            Créer un rendez-vous
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th><i class="fas fa-calendar"></i> Date</th>
                                    <th><i class="fas fa-clock"></i> Heure</th>
                                    <th><i class="fas fa-user"></i> Patient</th>
                                    <th><i class="fas fa-user-md"></i> Dentiste</th>
                                    <th><i class="fas fa-info-circle"></i> Statut</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="rdv" items="${rendezvous}" begin="0" end="4">
                                    <tr>
                                        <td>
                                            <strong>
                                                <fmt:formatDate value="${rdv.dateRv}" pattern="dd/MM/yyyy" />
                                            </strong>
                                        </td>
                                        <td>${rdv.heureRv}</td>
                                        <td>
                                            <div style="display: flex; align-items: center;">
                                                <div class="patient-avatar">
                                                    ${fn:substring(rdv.patient.prenomP, 0, 1)}${fn:substring(rdv.patient.nomP, 0, 1)}
                                                </div>
                                                <strong>${rdv.patient.nomP} ${rdv.patient.prenomP}</strong>
                                            </div>
                                        </td>
                                        <td>
                                            <i class="fas fa-user-md" style="color: #667eea; margin-right: 5px;"></i>
                                            Dr. ${rdv.dentiste.nomD} ${rdv.dentiste.prenomD}
                                        </td>
                                        <td>
                                            <span class="status-badge status-${fn:replace(rdv.statutRv, ' ', '-')}">
                                                ${rdv.statutRv}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <c:if test="${fn:length(rendezvous) > 5}">
                        <div style="text-align: center; margin-top: 20px;">
                            <a href="${pageContext.request.contextPath}/rendezvous/list" class="btn btn-primary">
                                <i class="fas fa-eye"></i>
                                Voir les ${fn:length(rendezvous) - 5} autres rendez-vous
                            </a>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Publications Section -->
        <div class="section" id="publications">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-newspaper"></i>
                    Publications Récentes
                </h2>
             
            </div>

            <c:choose>
                <c:when test="${empty publications}">
                    <div class="empty-state">
                        <i class="fas fa-newspaper"></i>
                        <p>Aucune publication disponible</p>
                        <a href="${pageContext.request.contextPath}/publications/add" class="btn btn-primary" style="margin-top: 20px;">
                            <i class="fas fa-plus-circle"></i>
                            Créer une publication
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th><i class="fas fa-heading"></i> Titre</th>
                                    <th><i class="fas fa-folder"></i> Catégorie</th>
                                    <th><i class="fas fa-calendar"></i> Date</th>
                                    <th><i class="fas fa-align-left"></i> Résumé</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pub" items="${publications}" begin="0" end="4">
                                    <tr>
                                        <td>
                                            <strong style="color: #667eea;">
                                                <i class="fas fa-file-alt"></i> ${pub.titre}
                                            </strong>
                                        </td>
                                        <td>
                                            <span style="background: #f0f0f0; padding: 4px 10px; border-radius: 12px; font-size: 0.85rem;">
                                                ${pub.categorie}
                                            </span>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${pub.dateNP}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                            ${fn:substring(pub.resume, 0, 80)}
                                            <c:if test="${fn:length(pub.resume) > 80}">...</c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <c:if test="${fn:length(publications) > 5}">
                        <div style="text-align: center; margin-top: 20px;">
                            <a href="${pageContext.request.contextPath}/publications" class="btn btn-primary">
                                <i class="fas fa-eye"></i>
                                Voir les ${fn:length(publications) - 5} autres publications
                            </a>
                        </div>
                    </c:if>
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

        // Add loading animation to stat cards
        const statCards = document.querySelectorAll('.stat-card');
        statCards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            setTimeout(() => {
                card.style.transition = 'all 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    </script>
</body>
</html>