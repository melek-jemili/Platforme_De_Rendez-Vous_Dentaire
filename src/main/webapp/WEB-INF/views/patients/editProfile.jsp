<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier le profil</title>
</head>
<body>
<h2>Modifier mon profil</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/patients/update" method="post" enctype="multipart/form-data">

    <label>Nom :</label>
    <input type="text" name="nomP" value="${patient.nomP}" required><br>

    <label>Prénom :</label>
    <input type="text" name="prenomP" value="${patient.prenomP}" required><br>

    <label>Email :</label>
    <input type="email" name="emailP" value="${patient.emailP}" required><br>

    <label>Groupe sanguin :</label>
    <input type="text" name="groupeSanguinP" value="${patient.groupeSanguinP}"><br>

	<label>Photo :</label>
    <input type="file" name="photoP" accept="image/jpeg"><br>

    <label>Sexe :</label>
    <input type="text" name="sexeP" value="${patient.sexeP}"><br>

    <label>Date de naissance :</label>
    <input type="date" name="dateNP" value="<c:out value='${patient.dateNP}'/>"><br>

    <label>Recouvrement :</label>
    <input type="text" name="recouvrementP" value="${patient.recouvrementP}"><br>

    <label>Mot de passe :</label>
    <input type="password" name="mdpP" value="${patient.mdpP}" required><br>

    <button type="submit">Enregistrer les modifications</button>
</form>

<a href="${pageContext.request.contextPath}/patient/profile">Annuler</a>
</body>
</html>
