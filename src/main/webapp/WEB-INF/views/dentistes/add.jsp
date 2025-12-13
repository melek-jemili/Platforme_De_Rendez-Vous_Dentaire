<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Dentiste</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/dentistes" class="back-link">← Retour à la liste</a>
        
        <h1>Ajouter un Dentiste</h1>
        
        <form action="${pageContext.request.contextPath}/dentistes/add" method="post">
            <div class="form-group">
                <label for="nomD">Nom :</label>
                <input type="text" id="nomD" name="nomD" required>
            </div>
            
            <div class="form-group">
                <label for="prenomD">Prénom :</label>
                <input type="text" id="prenomD" name="prenomD" required>
            </div>
            
            <div class="form-group">
                <label for="emailD">Email :</label>
                <input type="email" id="emailD" name="emailD" required>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Ajouter</button>
                <a href="${pageContext.request.contextPath}/dentistes" class="btn">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>