<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.entities.ServiceMedical" %>
<%
    ServiceMedical service = (ServiceMedical) request.getAttribute("service");
    if (service == null) {
        response.sendRedirect(request.getContextPath() + "/servicesmedicaux");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier le Service Médical</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/servicemedical/edit.css">

</head>
<body>
    <div class="container">
        <h1>Modifier le Service Médical</h1>
        <p class="subtitle">Mettez à jour les informations du service médical</p>
        
        <div class="service-id">
            <strong>Service N°:</strong> <%= service.getNumSM() %>
        </div>
        
        <form action="${pageContext.request.contextPath}/servicesmedicaux/update" method="post">
            <input type="hidden" name="numSM" value="<%= service.getNumSM() %>">
            
            <div class="form-group">
                <label for="nomSM">Nom du Service <span>*</span></label>
                <input type="text" id="nomSM" name="nomSM" required 
                       value="<%= service.getNomSM() != null ? service.getNomSM() : "" %>"
                       placeholder="Ex: Consultation générale">
            </div>
            
            <div class="form-group">
                <label for="typeSM">Type de Service <span>*</span></label>
                <select id="typeSM" name="typeSM" required>
                    <option value="">-- Sélectionner un type --</option>
                    <option value="Consultation" <%= "Consultation".equals(service.getTypeSM()) ? "selected" : "" %>>Consultation</option>
                    <option value="Chirurgie" <%= "Chirurgie".equals(service.getTypeSM()) ? "selected" : "" %>>Chirurgie</option>
                    <option value="Imagerie" <%= "Imagerie".equals(service.getTypeSM()) ? "selected" : "" %>>Imagerie</option>
                    <option value="Laboratoire" <%= "Laboratoire".equals(service.getTypeSM()) ? "selected" : "" %>>Laboratoire</option>
                    <option value="Urgence" <%= "Urgence".equals(service.getTypeSM()) ? "selected" : "" %>>Urgence</option>
                    <option value="Hospitalisation" <%= "Hospitalisation".equals(service.getTypeSM()) ? "selected" : "" %>>Hospitalisation</option>
                    <option value="Rééducation" <%= "Rééducation".equals(service.getTypeSM()) ? "selected" : "" %>>Rééducation</option>
                    <option value="Autre" <%= "Autre".equals(service.getTypeSM()) ? "selected" : "" %>>Autre</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="descriptionSM">Description</label>
                <textarea id="descriptionSM" name="descriptionSM" 
                          placeholder="Décrivez le service médical..."><%= service.getDescriptionSM() != null ? service.getDescriptionSM() : "" %></textarea>
            </div>
            
            <div class="form-group">
                <label for="tarifSM">Tarif (TND) <span>*</span></label>
                <div class="input-group">
                    <span class="input-prefix">TND</span>
                    <input type="number" id="tarifSM" name="tarifSM" 
                           class="input-with-prefix"
                           step="0.01" min="0" required 
                           value="<%= service.getTarifSM() != null ? service.getTarifSM() : "" %>"
                           placeholder="0.00">
                </div>
            </div>
            
            <div class="button-group">
                <button type="button" class="btn-cancel" 
                        onclick="window.location.href='${pageContext.request.contextPath}/servicesmedicaux'">
                    Annuler
                </button>
                <button type="submit" class="btn-submit">
                    Enregistrer les Modifications
                </button>
            </div>
        </form>
    </div>
</body>
</html>