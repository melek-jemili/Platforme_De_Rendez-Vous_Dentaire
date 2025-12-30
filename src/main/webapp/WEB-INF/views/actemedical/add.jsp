<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Acte Médical</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/actemedical/add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>
    <div class="container">
        <h1>
            <i class="fas fa-stethoscope"></i>
            Ajouter un Acte Médical
        </h1>
        <p class="subtitle">Enregistrez un nouvel acte médical pour un rendez-vous</p>
        
        <c:if test="${empty rendezvousList || empty servicesList}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Aucun rendez-vous ou service médical disponible. Veuillez d'abord créer des rendez-vous et des services.</span>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/actesmedicaux/add" method="post">
            
            <div class="form-group">
                <label for="idRv">
                    Rendez-vous <span>*</span>
                    <i class="fas fa-info-circle info-icon" title="Sélectionnez le rendez-vous concerné"></i>
                </label>
                <select id="idRv" name="idRv" required>
                    <option value="">-- Sélectionner un rendez-vous --</option>
                    <c:forEach var="rdv" items="${rendezvousList}">
                        <option value="${rdv.idRv}">
                            RDV #${rdv.idRv} - ${rdv.patient.nomP} ${rdv.patient.prenomP} 
                            - <fmt:formatDate value="${rdv.dateRv}" pattern="dd/MM/yyyy HH:mm"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            
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
                                data-tarif="${service.tarifSM}">
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
                          placeholder="Ex: Extraction de la dent 36, anesthésie locale, sutures..."></textarea>
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
                    <i class="fas fa-check"></i>
                    Enregistrer l'Acte
                </button>
            </div>
        </form>
    </div>

    <script>
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
                
               
                tarifInput.value = parseFloat(tarif).toFixed(2);
                
                serviceInfo.classList.add('active');
            } else {
                serviceInfo.classList.remove('active');
                tarifInput.value = '';
            }
        }
    </script>
</body>
</html>