<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier mon Profil - ${patient.nomP}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient/edit.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/patient/dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <i class="fas fa-chevron-right"></i>
            <a href="${pageContext.request.contextPath}/patient/profile">
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
                <form action="${pageContext.request.contextPath}/patients/update" method="post" enctype="multipart/form-data">
                    
                    <!-- Photo de Profil -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-camera"></i>
                            Photo de Profil
                        </label>
                        <div class="photo-upload">
                            <div class="current-photo">
                                <c:choose>
                                    <c:when test="${not empty patient.photoP}">
                                        <img src="${pageContext.request.contextPath}/${patient.photoP}" alt="Photo actuelle" id="photoPreview">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-md" id="photoPreview"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="file-input-wrapper">
                                <label for="photoP" class="file-input-label">
                                    <i class="fas fa-upload"></i>
                                    Choisir une nouvelle photo
                                </label>
                                <input type="file" id="photoP" name="photoP" accept="image/*">
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
                            <input type="text" name="nomP" value="${patient.nomP}" required>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-user"></i>
                                Prénom
                                <span class="required">*</span>
                            </label>
                            <input type="text" name="prenomP" value="${patient.prenomP}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-venus-mars"></i>
                                Sexe
                                <span class="required">*</span>
                            </label>
                            <select name="sexeP" required>
                                <option value="">-- Sélectionner --</option>
                                <option value="M" ${patient.sexeP == 'M' ? 'selected' : ''}>Masculin</option>
                                <option value="F" ${patient.sexeP == 'F' ? 'selected' : ''}>Féminin</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-calendar"></i>
                                Date de naissance
                                <span class="required">*</span>
                            </label>
                            <input type="date" name="dateNP" value="${patient.dateNP}" required>
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
                            <input type="email" name="emailP" value="${patient.emailP}" required>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-tint"></i>
                                Groupe Sanguin
                            </label>
                            <input type="text" name="groupeSanguinP" value="${patient.groupeSanguinP}">
                        </div>
                        <div class="form-group">
                            <label>
                                <i class="fas fa-book-medical"></i>
                                Recouvrement
                            </label>
                            <input type="text" name="recouvrementP" value="${patient.recouvrementP}">
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
                        <input type="password" name="mdpP" placeholder="Laisser vide pour ne pas changer">
                        <p class="password-note">
                            <i class="fas fa-info-circle"></i>
                            Laissez ce champ vide si vous ne souhaitez pas modifier votre mot de passe
                        </p>
                    </div>

                    <!-- Boutons -->
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/patient/profile" class="btn btn-cancel">
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
       
        const photoInput = document.getElementById('photoP');
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