<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une Publication</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/publication/addpub.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
                     <label>
        <i class="fas fa-barcode"></i>
        Référence de la publication
        <span class="required">*</span>
    </label>
    <input type="text" name="idPub" placeholder="Ex: 00020" required>
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
    
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.querySelector('input[name="dateNP"]');
            if (dateInput && !dateInput.value) {
                const today = new Date().toISOString().split('T')[0];
                dateInput.value = today;
            }
        });

        
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