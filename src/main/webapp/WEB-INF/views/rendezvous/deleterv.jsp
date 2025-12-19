<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Supprimer le rendez-vous</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="background-overlay"></div>

<div class="login-wrapper dashboard-wrapper">
    <div class="form-section">
        <div class="form-container dashboard-content">

            <h2><i class="fas fa-trash-alt"></i> Supprimer le rendez-vous</h2>

            <p>Voulez-vous vraiment supprimer ce rendez-vous ?</p>

            <div class="rdv-card">
                <p><strong>Date :</strong> ${rdv.dateRv}</p>
                <p><strong>Heure :</strong> ${rdv.heureRv}</p>
                <p><strong>Dentiste :</strong> ${rdv.dentiste.nomD} ${rdv.dentiste.prenomD}</p>
                <p><strong>Statut :</strong> ${rdv.statutRv}</p>
                <p><strong>Détails :</strong> ${rdv.detailsRv}</p>
            </div>

            <form action="${pageContext.request.contextPath}/rendezvous/delete" method="post">
                <input type="hidden" name="idRv" value="${rdv.idRv}">
                <button type="submit" class="btn-delete">
                    <i class="fas fa-trash-alt"></i> Supprimer
                </button>
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn-cancel">
                    <i class="fas fa-arrow-left"></i> Annuler
                </a>
            </form>

        </div>
    </div>
</div>

</body>
</html>
