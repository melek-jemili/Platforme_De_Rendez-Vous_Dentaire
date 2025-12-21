<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Service Médical</title>
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