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
            max-width: 600px;
        }
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        
        .service-id {
            background: #f8f9fa;
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 25px;
            border-left: 4px solid #667eea;
        }
        
        .service-id strong {
            color: #667eea;
            font-weight: 600;
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
        
        input[type="text"],
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
        
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        textarea {
            resize: vertical;
            min-height: 100px;
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