<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier le rendez-vous</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="background-overlay"></div>

<div class="login-wrapper dashboard-wrapper">
    <div class="form-section">
        <div class="form-container dashboard-content">

            <h2><i class="fas fa-edit"></i> Modifier le rendez-vous</h2>

            <c:if test="${not empty error}">
                <p style="color:red">${error}</p>
            </c:if>

            <form action="${pageContext.request.contextPath}/rendezvous/update" method="post">
                <input type="hidden" name="idRv" value="${rdv.idRv}">

                <label for="dateRv">Date :</label>
                <input type="date" id="dateRv" name="dateRv" value="${rdv.dateRv}" required><br>

                <label for="heureRv">Heure :</label>
                <input type="time" id="heureRv" name="heureRv" value="${rdv.heureRv}" required><br>

                <label for="idD">Dentiste :</label>
                <select id="idD" name="idD" required>
                    <c:forEach items="${dentistes}" var="d">
                        <option value="${d.idD}" <c:if test="${d.idD == rdv.dentiste.idD}">selected</c:if>>
                            ${d.nomD} ${d.prenomD}
                        </option>
                    </c:forEach>
                </select><br>

                <label for="statutRv">Statut :</label>
                <input type="text" id="statutRv" name="statutRv" value="${rdv.statutRv}" required><br>

                <label for="detailsRv">Détails :</label>
                <textarea id="detailsRv" name="detailsRv" rows="4">${rdv.detailsRv}</textarea><br>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-save"></i> Enregistrer les modifications
                </button>
            </form>

            <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn-cancel">
                <i class="fas fa-arrow-left"></i> Retour au dashboard
            </a>

        </div>
    </div>
</div>

</body>
</html>
