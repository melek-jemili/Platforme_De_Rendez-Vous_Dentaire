<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.project.entities.ActeMedical" %>
<%
    ActeMedical acte = (ActeMedical) request.getAttribute("acte");
    if (acte == null) {
        response.sendRedirect(request.getContextPath() + "/actesmedicaux");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier l'Acte Médical</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/actemedical/edit.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>
    <div class="container">
        <h1>
            <i class="fas fa-edit"></i>
            Modifier l'Acte Médical
        </h1>
        <p class="subtitle">Mettez à jour les informations de l'acte médical</p>
        
        <div class="acte-id">
            <strong>Acte Médical N°:</strong> <%= acte.getIdAM() %>
        </div>
        
        <!-- Informations du Rendez-vous -->
        <div class="info-card">
            <h3>
                <i class="fas fa-calendar-check"></i>
                Informations du Rendez-vous
            </h3>
            <p>
                <strong>Patient:</strong> 
                <%= acte.getRendezvous().getPatient().getNomP() %> 
                <%= acte.getRendezvous().getPatient().getPrenomP() %>
            </p>
            <p>
                <strong>Date:</strong> 
                <fmt:formatDate value="${acte.rendezvous.dateRv}" pattern="dd/MM/yyyy à HH:mm"/>
            </p>
            <p>
                <strong>Dentiste:</strong> 
                <%= acte.getRendezvous().getDentiste().getNomD() %> 
                <%= acte.getRendezvous().getDentiste().getPrenomD() %>
            </p>
        </div>
        
        <form action="${pageContext.request.contextPath}/actesmedicaux/update" method="post">
            <input type="hidden" name="idAM" value="<%= acte.getIdAM() %>">
            <input type="hidden" name="idRv" value="<%= acte.getRendezvous().getIdRv() %>">
            
            <div class="form-group">
                <label for="numSM">
                    Service Médical <span>*</span>
                    <i class="fas fa-info-circle info-icon" title="Sélectionnez le service médical réalisé"></i>
                </label>
                <select id="numSM" name="numSM" required onchange="updateServiceInfo(this)">
                    <option value="">-- Sélectionner un service --</option>
                    <c:forEach var="service" items="${servicesList}">
                        <option value="${service.numSM}" 
                                data-type="${service.typeSM}"
                                data-description="${service.descriptionSM}"
                                data-tarif="${service.tarifSM}"
                                ${service.numSM == acte.serviceMedical.numSM ? 'selected' : ''}>
                            ${service.nomSM} (${service.typeSM}) - 
                            <fmt:formatNumber value="${service.tarifSM}" pattern="#,##0.00"/> DT
                        </option>
                    </c:forEach>
                </select>
                
                <div id="serviceInfo" class="service-info">
                    <p><strong>Type:</strong> <span id="infoType"></span></p>
                    <p><strong>Description:</strong> <span id="infoDescription"></span></p>
                    <p><strong>Tarif de base:</strong> <span id="infoTarif" class="service-price"></span></p>
                </div>
            </div>
            
            <div class="form-group">
                <label for="descriptionAM">
                    Description / Notes de l'acte
                    <i class="fas fa-info-circle info-icon" title="Détails supplémentaires sur l'acte réalisé"></i>
                </label>
                <textarea id="descriptionAM" name="descriptionAM" 
                          placeholder="Ex: Extraction de la dent 36, anesthésie locale, sutures..."><%= acte.getDescriptionAM() != null ? acte.getDescriptionAM() : "" %></textarea>
            </div>
            
            <div class="form-group">
                <label for="tarifAM">
                    Tarif Appliqué (DT) <span>*</span>
                    <i class="fas fa-info-circle info-icon" title="Le tarif peut être modifié selon la complexité"></i>
                </label>
                <div class="input-group">
                    <span class="input-prefix">DT</span>
                    <input type="number" id="tarifAM" name="tarifAM" 
                           class="input-with-prefix"
                           step="0.01" min="0" required 
                           value="<%= acte.getTarifAM() != null ? acte.getTarifAM() : "" %>"
                           placeholder="0.00">
                </div>
            </div>
            
            <div class="button-group">
                <button type="button" class="btn-cancel" 
                        onclick="window.location.href='${pageContext.request.contextPath}/actesmedicaux'">
                    <i class="fas fa-times"></i>
                    Annuler
                </button>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-save"></i>
                    Enregistrer les Modifications
                </button>
            </div>
        </form>
    </div>

    <script>
        
        window.addEventListener('DOMContentLoaded', function() {
            const select = document.getElementById('numSM');
            if (select.value) {
                updateServiceInfo(select);
            }
        });
        
        function updateServiceInfo(select) {
            const selectedOption = select.options[select.selectedIndex];
            const serviceInfo = document.getElementById('serviceInfo');
            const tarifInput = document.getElementById('tarifAM');
            
            if (selectedOption.value) {
                const type = selectedOption.dataset.type || 'Non spécifié';
                const description = selectedOption.dataset.description || 'Aucune description disponible';
                const tarif = selectedOption.dataset.tarif || '0.00';
                
                document.getElementById('infoType').textContent = type;
                document.getElementById('infoDescription').textContent = description;
                document.getElementById('infoTarif').textContent = parseFloat(tarif).toFixed(2) + ' DT';
                
                serviceInfo.classList.add('active');
            } else {
                serviceInfo.classList.remove('active');
            }
        }
    </script>
</body>
</html>