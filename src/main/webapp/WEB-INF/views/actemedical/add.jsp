<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Acte Médical</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 700px;
        }
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        h1 i {
            color: #667eea;
            font-size: 26px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 14px;
        }
        
        label span {
            color: #e74c3c;
        }
        
        label .info-icon {
            color: #999;
            font-size: 12px;
            margin-left: 5px;
            cursor: help;
        }
        
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        select {
            cursor: pointer;
            background: white;
        }
        
        select option {
            padding: 10px;
        }
        
        textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-prefix {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-weight: 500;
        }
        
        .input-with-prefix {
            padding-left: 45px;
        }
        
        .service-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 6px;
            margin-top: 10px;
            border-left: 4px solid #667eea;
            display: none;
        }
        
        .service-info.active {
            display: block;
            animation: slideDown 0.3s ease;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .service-info p {
            margin: 5px 0;
            color: #666;
            font-size: 14px;
        }
        
        .service-info strong {
            color: #333;
        }
        
        .service-price {
            color: #2ecc71;
            font-size: 18px;
            font-weight: 700;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        button {
            flex: 1;
            padding: 14px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-cancel {
            background: #f5f5f5;
            color: #666;
        }
        
        .btn-cancel:hover {
            background: #e0e0e0;
        }
        
        .alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-warning {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            color: #856404;
        }
        
        .alert i {
            font-size: 20px;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }
            
            h1 {
                font-size: 24px;
            }
            
            .button-group {
                flex-direction: column;
            }
        }
    </style>
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
                
                // Pré-remplir le tarif
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