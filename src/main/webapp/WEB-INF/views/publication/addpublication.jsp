<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une Publication</title>
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
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 800px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .form-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }

        .form-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid #667eea;
        }

        .form-header i {
            font-size: 2rem;
            color: #667eea;
        }

        .form-header h2 {
            color: #333;
            font-size: 1.8rem;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .form-group label i {
            color: #667eea;
            margin-right: 8px;
            width: 20px;
        }

        .required {
            color: #e74c3c;
            margin-left: 3px;
        }

        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group input[type="file"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-group select {
            cursor: pointer;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-cancel {
            background: #95a5a6;
            color: white;
        }

        .btn-cancel:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert i {
            font-size: 1.3rem;
        }

        .alert-error {
            background: #fee;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
        }

        .alert-success {
            background: #efe;
            border-left: 4px solid #27ae60;
            color: #229954;
        }

        .file-input-wrapper {
            position: relative;
        }

        .file-input-label {
            display: inline-block;
            padding: 10px 20px;
            background: #f8f9fa;
            border: 2px dashed #d0d0d0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            width: 100%;
        }

        .file-input-label:hover {
            background: #e9ecef;
            border-color: #667eea;
        }

        .file-input-label i {
            color: #667eea;
            margin-right: 8px;
        }

        input[type="file"] {
            display: none;
        }

        .file-name {
            margin-top: 8px;
            font-size: 0.9rem;
            color: #666;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .form-card {
                padding: 25px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-newspaper"></i> Publications</h1>
            <p>Partagez vos publications avec la communauté</p>
        </div>

        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-plus-circle"></i>
                <h2>Nouvelle Publication</h2>
            </div>

            <!-- Messages d'erreur/succès -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${errorMessage}</span>
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${successMessage}</span>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/publications/add" method="post">
                
                <!-- Titre -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-heading"></i>
                        Titre de la publication
                        <span class="required">*</span>
                    </label>
                    <input type="text" name="titre" placeholder="Ex: Nouvelles techniques en orthodontie" required>
                </div>

                <!-- Catégorie et Date -->
                <div class="form-row">
                    <div class="form-group">
                        <label>
                            <i class="fas fa-folder"></i>
                            Catégorie
                            <span class="required">*</span>
                        </label>
                        <select name="categorie" required>
                            <option value="">-- Sélectionner --</option>
                            <option value="Recherche">Recherche</option>
                            <option value="Article">Article</option>
                            <option value="Étude de cas">Étude de cas</option>
                            <option value="Guide pratique">Guide pratique</option>
                            <option value="Revue">Revue</option>
                            <option value="Formation">Formation</option>
                            <option value="Actualité">Actualité</option>
                            <option value="Autre">Autre</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-calendar"></i>
                            Date de publication
                            <span class="required">*</span>
                        </label>
                        <input type="date" name="dateNP" required>
                    </div>
                </div>

                <!-- Résumé -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-align-left"></i>
                        Résumé
                        <span class="required">*</span>
                    </label>
                    <textarea name="resume" placeholder="Décrivez brièvement le contenu de votre publication..." required></textarea>
                </div>

                <!-- Affiche -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-image"></i>
                        URL de l'affiche/image
                    </label>
                    <input type="text" name="affiche" placeholder="https://exemple.com/image.jpg">
                    <small style="color: #777; font-size: 0.85rem; display: block; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> Lien vers une image illustrative (facultatif)
                    </small>
                </div>

                <!-- Fichier -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-file-pdf"></i>
                        URL du fichier
                    </label>
                    <input type="text" name="fichier" placeholder="https://exemple.com/document.pdf">
                    <small style="color: #777; font-size: 0.85rem; display: block; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> Lien vers le document complet (PDF, DOC, etc.)
                    </small>
                </div>

                <!-- Boutons -->
                <div class="btn-group">
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-paper-plane"></i>
                        Publier
                    </button>
                    <a href="${pageContext.request.contextPath}/publications" class="btn btn-cancel">
                        <i class="fas fa-times"></i>
                        Annuler
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Définir la date du jour par défaut
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.querySelector('input[name="dateNP"]');
            if (dateInput && !dateInput.value) {
                const today = new Date().toISOString().split('T')[0];
                dateInput.value = today;
            }
        });

        // Animation au focus des champs
        const inputs = document.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.01)';
            });
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>