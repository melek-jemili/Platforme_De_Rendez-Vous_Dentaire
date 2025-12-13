<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un Dentiste</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/dentistes" class="back-link">← Retour à la liste</a>
        
        <h1>Modifier un Dentiste</h1>
        
        <form action="${pageContext.request.contextPath}/dentistes/update" method="post">
            <input type="hidden" name="idD" value="${dentiste.idD}">
            
            <div class="form-group">
                <label for="nomD">Nom :</label>
                <input type="text" id="nomD" name="nomD" value="${dentiste.nomD}" required>
            </div>
            
            <div class="form-group">
                <label for="prenomD">Prénom :</label>
                <input type="text" id="prenomD" name="prenomD" value="${dentiste.prenomD}" required>
            </div>
            
            <div class="form-group">
                <label for="emailD">Email :</label>
                <input type="email" id="emailD" name="emailD" value="${dentiste.emailD}" required>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Modifier</button>
                <a href="${pageContext.request.contextPath}/dentistes" class="btn">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>