<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Créer un rendez-vous</title>
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

            <h2>Créer un rendez-vous</h2>
            <p>Remplissez les informations ci-dessous pour planifier votre rendez-vous.</p>

            <div class="features">
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="feature-item">
                    <i class="fas fa-arrow-left"></i>
                    <span>Retour au dashboard</span>
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="feature-item danger">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Se déconnecter</span>
                </a>
            </div>

        </div>
    </div>

    <!-- ===== FORMULAIRE ===== -->
    <div class="form-section">
        <div class="form-container dashboard-content">

            <form action="${pageContext.request.contextPath}/rendezvous/add" method="post">
                <div class="form-group">
                    <label for="dateRv"><i class="fas fa-calendar-day"></i> Date :</label>
                    <input type="date" name="dateRv" id="dateRv" required>
                </div>

                <div class="form-group">
                    <label for="heureRv"><i class="fas fa-clock"></i> Heure :</label>
                    <input type="time" name="heureRv" id="heureRv" required>
                </div>

                <div class="form-group">
                    <label for="idD"><i class="fas fa-user-md"></i> Choisir un dentiste :</label>
                    <select name="idD" id="idD" required>
                        <c:forEach items="${dentistes}" var="d">
                            <option value="${d.idD}">${d.nomD} ${d.prenomD}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="statutRv"><i class="fas fa-info-circle"></i> Statut :</label>
                    <input type="text" name="statutRv" id="statutRv" value="En attente" required>
                </div>

                <div class="form-group">
                    <label for="detailsRv"><i class="fas fa-align-left"></i> Détails :</label>
                    <textarea name="detailsRv" id="detailsRv" rows="4"></textarea>
                </div>

                <!-- Champ caché pour le patient connecté -->
                <input type="hidden" name="idP" value="${sessionScope.user.idP}">

                <button type="submit" class="btn-submit">
                    <i class="fas fa-calendar-plus"></i>
                     Créer le rendez-vous
                </button>
            </form>

        </div>
    </div>

</div>
</body>
</html>
