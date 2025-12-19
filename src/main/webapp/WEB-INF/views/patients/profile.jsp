<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mon Profil</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="background-overlay"></div>

<div class="login-wrapper dashboard-wrapper">

    <!-- ===== SIDEBAR ===== -->
    <div class="info-section">
        <div class="info-content">

            <div class="logo-section">
                <i class="fas fa-user-injured"></i>
                <h1>Patient<span>Space</span></h1>
            </div>

            <h2>Mon profil</h2>
            <p>Consultez vos informations personnelles</p>

            <div class="features">
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="feature-item">
                    <i class="fas fa-arrow-left"></i>
                    <span>Retour au dashboard</span>
                </a>

                <a href="${pageContext.request.contextPath}/" class="feature-item danger">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Se déconnecter</span>
                </a>
            </div>

        </div>
    </div>

    <!-- ===== CONTENU ===== -->
    <div class="form-section">
        <div class="form-container dashboard-content">
			 <form action="${pageContext.request.contextPath}/patient/profile" method="get">
            <h3><i class="fas fa-id-card"></i> Informations personnelles</h3>

            <div class="profile-card">
                <c:if test="${not empty patient.photoP}">
        <img src="${pageContext.request.contextPath}/${patient.photoP}" alt="Photo du patient" width="150">
    </c:if>
                <p><strong>Nom :</strong> ${patient.nomP}</p>
                <p><strong>Prénom :</strong> ${patient.prenomP}</p>
                <p><strong>Email :</strong> ${patient.emailP}</p>
                <p><strong>Sexe :</strong> ${patient.sexeP}</p>
                <p><strong>Date de naissance :</strong> ${patient.dateNP}</p>
                <p><strong>Groupe sanguin :</strong> ${patient.groupeSanguinP}</p>
                <p><strong>Recouvrement :</strong> ${patient.recouvrementP}</p>
            </div>

        </div>
    <button type="submit" class="btn-edit">
    <a href="${pageContext.request.contextPath}/patients/update" class="btn-edit">
    <i class="fas fa-edit"></i> Modifier mon profil
</a>
    </button>
</form>
    </div>

</div>
</body>
</html>
