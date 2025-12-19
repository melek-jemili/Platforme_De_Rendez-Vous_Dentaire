<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Patient</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="background-overlay"></div>

<div class="login-wrapper dashboard-wrapper">

    <!-- ===== SIDEBAR (gauche) ===== -->
    <div class="info-section">
        <div class="info-content">

            <div class="logo-section">
                <i class="fas fa-user-injured"></i>
                <h1>Patient<span>Space</span></h1>
            </div>

            <c:set var="patient" value="${sessionScope.patient}" />
            <h2>Bienvenue, ${patient.prenomP}</h2>
            <p>Gérez vos rendez-vous et votre profil en toute simplicité.</p>

            <div class="features">
                <a href="${pageContext.request.contextPath}/rendezvous/add" class="feature-item">
                    <i class="fas fa-calendar-plus"></i>
                    <span>Créer un rendez-vous</span>
                </a>

                <a href="${pageContext.request.contextPath}/patient/profile" class="feature-item">
                    <i class="fas fa-user"></i>
                    <span>Voir mon profil</span>
                </a>

                <a href="${pageContext.request.contextPath}/" class="feature-item danger">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Se déconnecter</span>
                </a>
            </div>

        </div>
    </div>

    <!-- ===== CONTENU PRINCIPAL (droite) ===== -->
    <div class="form-section">
    <div class="form-container dashboard-content">

        <h3><i class="fas fa-calendar-check"></i> Mes rendez-vous</h3>

        <c:if test="${empty Rendezvous}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>
                Aucun rendez-vous trouvé.
            </div>
        </c:if>

        <c:forEach items="${Rendezvous}" var="rdv">
            <div class="rdv-card">
                <div>
                    <strong>Date :</strong> ${rdv.dateRv}<br>
                    <strong>Heure :</strong> ${rdv.heureRv}<br>
                    <strong>Médecin :</strong> ${rdv.dentiste.nomD}
                </div>
                <span class="rdv-status">${rdv.statutRv}</span>
                                    <!-- Boutons Actions -->
                    <div class="rdv-actions">
                        <!-- Modifier -->
                        <form action="${pageContext.request.contextPath}/rendezvous/update" method="get" style="display:inline;">
                            <input type="hidden" name="idRv" value="${rdv.idRv}">
                            <button type="submit" class="btn-edit">
                                <i class="fas fa-edit"></i> Modifier
                            </button>
                        </form>

                        <!-- Supprimer -->
                        <form action="${pageContext.request.contextPath}/rendezvous/delete" method="get" style="display:inline;" 
                              onsubmit="return confirm('Voulez-vous vraiment supprimer ce rendez-vous ?');">
                            <input type="hidden" name="idRv" value="${rdv.idRv}">
                            <button type="submit" class="btn-delete">
                                <i class="fas fa-trash-alt"></i> Supprimer
                            </button>
                        </form>
                    </div>
                
            </div>
        </c:forEach>

    </div>
</div>

</div>

</body>
</html>
