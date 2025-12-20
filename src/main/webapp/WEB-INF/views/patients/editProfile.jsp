<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier mon Profil - ${patient.nomP}</title>
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
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .breadcrumb {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95rem;
        }

        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
            transition: all 0.3s;
        }

        .breadcrumb a:hover {
            color: #764ba2;
        }

        .breadcrumb i {
            color: #999;
            font-size: 0.8rem;
        }

        .breadcrumb span {
            color: #666;
        }

        .form-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px;
            text-align: center;
            color: white;
        }

        .form-header i {
            font-size: 3.5rem;
            margin-bottom: 15px;
        }

        .form-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .form-content {
            padding: 40px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #333;
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #667eea;
        }

        .section-title i {
            color: #667eea;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
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
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group input[type="password"],
        .form-group input[type="date"],
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group input:disabled {
            background: #f5f5f5;
            cursor: not-allowed;
        }

        .photo-upload {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .current-photo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid #667eea;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: #667eea;
        }

        .current-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .file-input-wrapper {
            flex: 1;
        }

        .file-input-label {
            display: block;
            padding: 12px 20px;
            background: #f8f9fa;
            border: 2px dashed #d0d0d0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
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

        .password-note {
            font-size: 0.85rem;
            color: #666;
            margin-top: 5px;
            font-style: italic;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #f0f0f0;
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
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-error {
            background: #f8d7da;
            border-left: 4px solid #dc3545;
            color: #721c24;
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .form-content {
                padding: 25px 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .btn-group {
                flex-direction: column;
            }

            .photo-upload {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
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
        // Preview photo upload
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

        // Auto-hide alerts
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