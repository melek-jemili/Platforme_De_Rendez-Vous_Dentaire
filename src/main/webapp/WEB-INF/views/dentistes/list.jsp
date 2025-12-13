<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Dentistes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="back-link">← Retour à l'accueil</a>
        
        <div class="header-actions">
            <h1>Liste des Dentistes</h1>
            <a href="${pageContext.request.contextPath}/dentistes/add" class="btn btn-primary">+ Ajouter un Dentiste</a>
        </div>
        
        <c:choose>
            <c:when test="${empty dentistes}">
                <p class="no-data">Aucun dentiste trouvé. Ajoutez-en un !</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dentiste" items="${dentistes}">
                            <tr>
                                <td>${dentiste.idD}</td>
                                <td>${dentiste.nomD}</td>
                                <td>${dentiste.prenomD}</td>
                                <td>${dentiste.emailD}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/WEB-INF/views/dentistes/edit.jsp?id=${dentiste.idD}" class="btn-warning">Modifier</a>
                                    <form action="${pageContext.request.contextPath}/dentistes/delete" method="post" style="display:inline;">
                                        <input type="hidden" name="idD" value="${dentiste.idD}">
                                        <button type="submit" class="btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce dentiste ?')">Supprimer</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>