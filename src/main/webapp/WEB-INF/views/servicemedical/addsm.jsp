<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Service Médical</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/servicemedical/add.css">

</head>
<body>
    <div class="container">
        <h1>Ajouter un Service Médical</h1>
        <p class="subtitle">Remplissez les informations du nouveau service médical</p>
        
        <form action="${pageContext.request.contextPath}/servicesmedicaux/add" method="post">
            <div class="form-group">
                <label for="nomSM">Nom du Service <span>*</span></label>
                <input type="text" id="nomSM" name="nomSM" required 
                       placeholder="Ex: Consultation générale">
            </div>
            
            <div class="form-group">
                <label for="typeSM">Type de Service <span>*</span></label>
                <select id="typeSM" name="typeSM" required>
                    <option value="">-- Sélectionner un type --</option>
                    <option value="Consultation">Consultation</option>
                    <option value="Chirurgie">Chirurgie</option>
                    <option value="Imagerie">Imagerie</option>
                    <option value="Laboratoire">Laboratoire</option>
                    <option value="Urgence">Urgence</option>
                    <option value="Hospitalisation">Hospitalisation</option>
                    <option value="Rééducation">Rééducation</option>
                    <option value="Autre">Autre</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="descriptionSM">Description</label>
                <textarea id="descriptionSM" name="descriptionSM" 
                          placeholder="Décrivez le service médical..."></textarea>
            </div>
            
            <div class="form-group">
                <label for="tarifSM">Tarif (TND) <span>*</span></label>
                <div class="input-group">
                    <span class="input-prefix">TND</span>
                    <input type="number" id="tarifSM" name="tarifSM" 
                           class="input-with-prefix"
                           step="0.01" min="0" required 
                           placeholder="0.00">
                </div>
            </div>
            
            <div class="button-group">
                <button type="button" class="btn-cancel" 
                        onclick="window.location.href='${pageContext.request.contextPath}/servicesmedicaux'">
                    Annuler
                </button>
                <button type="submit" class="btn-submit">
                    Ajouter le Service
                </button>
            </div>
        </form>
    </div>
</body>
</html>