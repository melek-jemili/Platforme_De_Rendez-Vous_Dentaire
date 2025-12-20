<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil -${sessionScope.aidesoignant.nom}</title>
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
            max-width: 1000px;
            margin: 0 auto;
        }

        /* Breadcrumb */
        .breadcrumb {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95rem;
        }

        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
            transition: all 0.3s;
        }

        .breadcrumb a:hover {
            color: #764ba2;
        }

        .breadcrumb i {
            color: #999;
            font-size: 0.8rem;
        }

        .breadcrumb span {
            color: #666;
        }

        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        /* Header Section */
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 50px;
            text-align: center;
            position: relative;
        }

        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 4rem;
            color: #667eea;
            border: 5px solid white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
        }

        .profile-name {
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .profile-specialty {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.3rem;
            margin-bottom: 20px;
        }

        .profile-badge {
            display: inline-block;
            padding: 10px 25px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            color: white;
            font-size: 1rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
        }

        /* Content Section */
        .profile-content {
            padding: 40px;
        }

        .section {
            margin-bottom: 40px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #333;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #667eea;
        }

        .section-title i {
            color: #667eea;
            font-size: 1.8rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .info-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            border-left: 4px solid #667eea;
            transition: all 0.3s;
        }

        .info-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .info-label {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #667eea;
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-label i {
            font-size: 1.2rem;
        }

        .info-value {
            color: #333;
            font-size: 1.2rem;
            font-weight: 500;
            word-break: break-word;
        }

        .empty-value {
            color: #999;
            font-style: italic;
        }

        /* Actions Section */
        .actions-section {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid #f0f0f0;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
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
            background: #3498db;
            color: white;
        }

        .btn-secondary:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        .btn-back {
            background: #95a5a6;
            color: white;
        }

        .btn-back:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
            opacity: 0.9;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 1rem;
            opacity: 0.9;
        }

        /* Alert Messages */
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

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .profile-header {
                padding: 30px 20px;
            }

            .profile-name {
                font-size: 2rem;
            }

            .profile-specialty {
                font-size: 1.1rem;
            }

            .profile-avatar {
                width: 120px;
                height: 120px;
                font-size: 3rem;
            }

            .profile-content {
                padding: 25px 20px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .actions-section {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/aidesoignant/dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <i class="fas fa-chevron-right"></i>
            <span>Mon Profil</span>
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

        <!-- Profile Card -->
        <div class="profile-card">
            <!-- Header -->
            <div class="profile-header">
                <div class="profile-avatar">
                    <c:choose>
                        <c:when test="${not empty aidesoignant.photoP}">
                            <img src="${pageContext.request.contextPath}/${aidesoignant.photoP}" alt="Photo de profil">
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-user-md"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                <h1 class="profile-name">${aidesoignant.nom} ${aidesoignant.prenom}</h1>
             
                <div class="profile-badge">
                    <i class="fas fa-id-badge"></i> ID: ${aidesoignant.idAS}
                </div>
            </div>

            <!-- Content -->
            <div class="profile-content">
                <!-- Informations Personnelles -->
                <div class="section">
                    <h2 class="section-title">
                        <i class="fas fa-user"></i>
                        Informations Personnelles
                    </h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-id-card"></i>
                                Nom
                            </div>
                            <div class="info-value">${aidesoignant.nom}</div>
                        </div>

                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-user"></i>
                                Prénom
                            </div>
                            <div class="info-value">${aidesoignant.prenom}</div>
                        </div>

                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-venus-mars"></i>
                                Sexe
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${aidesoignant.sexep == 'M'}">
                                        <i class="fas fa-mars" style="color: #3498db;"></i> Masculin
                                    </c:when>
                                    <c:when test="${aidesoignantt.sexeP == 'F'}">
                                        <i class="fas fa-venus" style="color: #e91e63;"></i> Féminin
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">Non spécifié</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Informations de Contact -->
                <div class="section">
                    <h2 class="section-title">
                        <i class="fas fa-address-book"></i>
                        Coordonnées
                    </h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-envelope"></i>
                                Email
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty aidesoignant.emailP}">
                                        <a href="mailto:${aidesoignant.emailp}" style="color: #667eea; text-decoration: none;">
                                            ${aidesoignant.emailP}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">Non renseigné</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-book-medical"></i>
                                Diplôme
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty aidesoignant.diplome}">
                                        <a href="tel:${aidesoignant.diplome}" style="color: #667eea; text-decoration: none;">
                                            ${aidesoignant.diplome}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">Non renseigné</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                          <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-clinic-medical"></i>
                               Adresse
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty aidesoignant.adresse}">
                                        <a href="tel:${aidesoignant.adresse}" style="color: #667eea; text-decoration: none;">
                                            ${aidesoignant.adresse}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">Non renseigné</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                                                    <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-calendar"></i>
                               Date de naissance:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty aidesoignant.dateNP}">
                                        <a href="tel:${aidesoignant.dateNP}" style="color: #667eea; text-decoration: none;">
                                            ${aidesoignant.dateNP}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">Non renseigné</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

              

                <!-- Actions -->
                <div class="actions-section">
                    <a href="${pageContext.request.contextPath}/aidesoignant/dashboard" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Retour au Dashboard
                    </a>

                    <a href="${pageContext.request.contextPath}/aidesoignants/update" class="btn btn-primary">
                        <i class="fas fa-edit"></i>
                        Modifier mon Profil
                    </a>

                  
                </div>
            </div>
        </div>
    </div>

    <script>
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