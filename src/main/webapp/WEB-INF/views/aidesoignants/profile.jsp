<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil -${sessionScope.aidesoignant.nom}</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aidesoignant/profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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