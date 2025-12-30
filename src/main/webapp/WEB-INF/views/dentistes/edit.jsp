<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier mon Profil - Dr. ${dentiste.nomD}</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dentiste/edit.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/dentiste/dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <i class="fas fa-chevron-right"></i>
            <a href="${pageContext.request.contextPath}/dentiste/profile">
                Mon Profil
            </a>
            <i class="fas fa-chevron-right"></i>
            <span>Modifier</span>
        </div>

        <!-- Messages -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Form Card -->
        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-user-edit"></i>
                <h1>Modifier mon Profil</h1>
                <p>Mettez à jour vos informations personnelles</p>
            </div>

            <div class="form-content">
                <form action="${pageContext.request.contextPath}/dentiste/update" method="post" enctype="multipart/form-data">
                    
                    <!-- Photo de Profil -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-camera"></i>
                            Photo de Profil
                        </label>
                        <div class="photo-upload">
                            <div class="current-photo">
                                <c:choose>
                                    <c:when test="${not empty dentiste.photoD}">
                                        <img src="${pageContext.request.contextPath}/${dentiste.photoD}" alt="Photo actuelle" id="photoPreview">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-md" id="photoPreview"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="file-input-wrapper">
                                <label for="photoD" class="file-input-label">
                                    <i class="fas fa-upload"></i>
                                    Choisir une nouvelle photo
                                </label>
                                <input type="file" id="photoD" name="photoD" accept="image/*">
                                <div class="file-name" id="fileName">Aucun fichier sélectionné</div>
                            </div>
                        </div>
                    </div>

                    <!-- Informations Personnelles -->
                    <h3 class="section-title">
                        <i class="fas fa-user"></i>
                        Informations Personnelles
                    </h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-id-card"></i>
                                Nom
                                <span class="required">*</span>
                            </label>
                            <input type="text" name="nomD" value="${dentiste.nomD}" required>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-user"></i>
                                Prénom
                                <span class="required">*</span>
                            </label>
                            <input type="text" name="prenomD" value="${dentiste.prenomD}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-venus-mars"></i>
                                Sexe
                                <span class="required">*</span>
                            </label>
                            <select name="sexeD" required>
                                <option value="">-- Sélectionner --</option>
                                <option value="M" ${dentiste.sexeD == 'M' ? 'selected' : ''}>Masculin</option>
                                <option value="F" ${dentiste.sexeD == 'F' ? 'selected' : ''}>Féminin</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-stethoscope"></i>
                                Spécialité
                            </label>
                            <input type="text" name="specialiteD" value="${dentiste.specialiteD}" 
                                   placeholder="Ex: Orthodontiste, Parodontiste...">
                        </div>
                    </div>

                    <!-- Coordonnées -->
                    <h3 class="section-title">
                        <i class="fas fa-address-book"></i>
                        Coordonnées
                    </h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-envelope"></i>
                                Email
                                <span class="required">*</span>
                            </label>
                            <input type="email" name="emailD" value="${dentiste.emailD}" required>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-phone"></i>
                                Téléphone
                            </label>
                            <input type="tel" name="telD" value="${dentiste.telD}" 
                                   placeholder="Ex: +216 12 345 678">
                        </div>
                    </div>

                    <!-- Sécurité -->
                    <h3 class="section-title">
                        <i class="fas fa-lock"></i>
                        Sécurité
                    </h3>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-key"></i>
                            Nouveau Mot de Passe
                        </label>
                        <input type="password" name="mdpD" placeholder="Laisser vide pour ne pas changer">
                        <p class="password-note">
                            <i class="fas fa-info-circle"></i>
                            Laissez ce champ vide si vous ne souhaitez pas modifier votre mot de passe
                        </p>
                    </div>

                    <!-- Boutons -->
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/dentiste/profile" class="btn btn-cancel">
                            <i class="fas fa-times"></i>
                            Annuler
                        </a>
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-save"></i>
                            Enregistrer les Modifications
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
      
        const photoInput = document.getElementById('photoD');
        const photoPreview = document.querySelector('.current-photo');
        const fileName = document.getElementById('fileName');

        photoInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                fileName.textContent = file.name;
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    photoPreview.innerHTML = '<img src="' + e.target.result + '" alt="Aperçu">';
                };
                reader.readAsDataURL(file);
            }
        });

       
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);
    </script>
</body>
</html>