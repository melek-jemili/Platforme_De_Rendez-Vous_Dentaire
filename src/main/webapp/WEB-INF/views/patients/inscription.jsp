<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Plateforme Rendez-Vous Médical</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/inscription.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="background-overlay"></div>
    
    <div class="inscription-wrapper">
        <!-- Header avec retour -->
        <div class="header-section">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-retour">
                <i class="fas fa-arrow-left"></i> Retour à la connexion
            </a>
        </div>

        <div class="inscription-container">
            <!-- Titre principal -->
            <div class="title-section">
                <div class="logo">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h1>Créer un compte</h1>
                <p>Rejoignez notre plateforme de rendez-vous médical</p>
            </div>

            <!-- Messages d'alerte -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>

            <!-- Choix du type de compte -->
            <div class="account-type-section">
                <h3><i class="fas fa-users"></i> Je suis :</h3>
                <div class="account-type-cards">
                    <label class="type-card" for="type-patient">
                        <input type="radio" name="accountType" id="type-patient" value="patient" checked>
                        <div class="card-content">
                            <i class="fas fa-user"></i>
                            <h4>Patient</h4>
                            <p>Je souhaite prendre rendez-vous</p>
                        </div>
                    </label>

                    <label class="type-card" for="type-aidesoignant">
                        <input type="radio" name="accountType" id="type-aidesoignant" value="aidesoignant">
                        <div class="card-content">
                            <i class="fas fa-user-nurse"></i>
                            <h4>Aide-soignant</h4>
                            <p>Je travaille dans le secteur médical</p>
                        </div>
                    </label>
                </div>
            </div>

            <!-- Formulaire Patient -->
            <form id="form-patient" class="inscription-form active" action="${pageContext.request.contextPath}/inscription" method="post">
                <input type="hidden" name="userType" value="patient">

                <div class="form-row">
                    <div class="form-group">
                        <label for="nomP">
                            <i class="fas fa-user"></i>
                            Nom <span class="required">*</span>
                        </label>
                        <input type="text" id="nomP" name="nomP" placeholder="Votre nom" required>
                    </div>

                    <div class="form-group">
                        <label for="prenomP">
                            <i class="fas fa-user"></i>
                            Prénom <span class="required">*</span>
                        </label>
                        <input type="text" id="prenomP" name="prenomP" placeholder="Votre prénom" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="emailP">
                        <i class="fas fa-envelope"></i>
                        Email <span class="required">*</span>
                    </label>
                    <input type="email" id="emailP" name="emailP" placeholder="votre.email@exemple.com" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="mdpP">
                            <i class="fas fa-lock"></i>
                            Mot de passe <span class="required">*</span>
                        </label>
                        <div class="password-wrapper">
                            <input type="password" id="mdpP" name="mdpP" placeholder="Min. 8 caractères" required minlength="8">
                            <button type="button" class="toggle-password" data-target="mdpP">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="mdpP-confirm">
                            <i class="fas fa-lock"></i>
                            Confirmer mot de passe <span class="required">*</span>
                        </label>
                        <div class="password-wrapper">
                            <input type="password" id="mdpP-confirm" name="mdpP-confirm" placeholder="Répéter le mot de passe" required>
                            <button type="button" class="toggle-password" data-target="mdpP-confirm">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="dateNP">
                            <i class="fas fa-calendar"></i>
                            Date de naissance <span class="required">*</span>
                        </label>
                        <input type="date" id="dateNP" name="dateNP" required>
                    </div>

                    <div class="form-group">
                        <label for="sexeP">
                            <i class="fas fa-venus-mars"></i>
                            Sexe <span class="required">*</span>
                        </label>
                        <select id="sexeP" name="sexeP" required>
                            <option value="">-- Sélectionner --</option>
                            <option value="M">Masculin</option>
                            <option value="F">Féminin</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="groupeSanguinP">
                            <i class="fas fa-tint"></i>
                            Groupe sanguin
                        </label>
                        <select id="groupeSanguinP" name="groupeSanguinP">
                            <option value="">-- Sélectionner --</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="O">O</option>
                            <option value="AB">AB</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="recouvrementP">
                            <i class="fas fa-shield-alt"></i>
                            Recouvrement social
                        </label>
                        <input type="text" id="recouvrementP" name="recouvrementP" placeholder="Ex: CNAM">
                    </div>
                </div>

                <div class="form-group">
                    <label class="checkbox-wrapper">
                        <input type="checkbox" name="acceptTerms" required>
                        <span>J'accepte les <a href="#" class="link">conditions d'utilisation</a> et la <a href="#" class="link">politique de confidentialité</a></span>
                    </label>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-user-plus"></i>
                    Créer mon compte patient
                </button>
            </form>

            <!-- Formulaire Aide-soignant -->
            <form id="form-aidesoignant" class="inscription-form" action="${pageContext.request.contextPath}/inscription" method="post">
                <input type="hidden" name="userType" value="aidesoignant">

                <div class="form-row">
                    <div class="form-group">
                        <label for="nomAS">
                            <i class="fas fa-user"></i>
                            Nom <span class="required">*</span>
                        </label>
                        <input type="text" id="nomAS" name="nom" placeholder="Votre nom" required>
                    </div>

                    <div class="form-group">
                        <label for="prenomAS">
                            <i class="fas fa-user"></i>
                            Prénom <span class="required">*</span>
                        </label>
                        <input type="text" id="prenomAS" name="prénom" placeholder="Votre prénom" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="emailAS">
                        <i class="fas fa-envelope"></i>
                        Email professionnel <span class="required">*</span>
                    </label>
                    <input type="email" id="emailAS" name="emailP" placeholder="votre.email@clinique.com" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="mdpAS">
                            <i class="fas fa-lock"></i>
                            Mot de passe <span class="required">*</span>
                        </label>
                        <div class="password-wrapper">
                            <input type="password" id="mdpAS" name="mdpP" placeholder="Min. 8 caractères" required minlength="8">
                            <button type="button" class="toggle-password" data-target="mdpAS">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="mdpAS-confirm">
                            <i class="fas fa-lock"></i>
                            Confirmer mot de passe <span class="required">*</span>
                        </label>
                        <div class="password-wrapper">
                            <input type="password" id="mdpAS-confirm" name="mdpP-confirm" placeholder="Répéter le mot de passe" required>
                            <button type="button" class="toggle-password" data-target="mdpAS-confirm">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="telephoneAS">
                            <i class="fas fa-phone"></i>
                            Téléphone <span class="required">*</span>
                        </label>
                        <input type="tel" id="telephoneAS" name="telephone" placeholder="20123456" required>
                    </div>

                    <div class="form-group">
                        <label for="dateNAS">
                            <i class="fas fa-calendar"></i>
                            Date de naissance <span class="required">*</span>
                        </label>
                        <input type="date" id="dateNAS" name="dateNP" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="sexeAS">
                            <i class="fas fa-venus-mars"></i>
                            Sexe <span class="required">*</span>
                        </label>
                        <select id="sexeAS" name="sexeP" required>
                            <option value="">-- Sélectionner --</option>
                            <option value="M">Masculin</option>
                            <option value="F">Féminin</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="diplomeAS">
                            <i class="fas fa-graduation-cap"></i>
                            Diplôme <span class="required">*</span>
                        </label>
                        <input type="text" id="diplomeAS" name="diplome" placeholder="Ex: Diplôme d'État" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="adresseAS">
                        <i class="fas fa-map-marker-alt"></i>
                        Adresse <span class="required">*</span>
                    </label>
                    <input type="text" id="adresseAS" name="adresse" placeholder="Votre adresse complète" required>
                </div>

                <div class="form-group">
                    <label class="checkbox-wrapper">
                        <input type="checkbox" name="acceptTerms" required>
                        <span>J'accepte les <a href="#" class="link">conditions d'utilisation</a> et la <a href="#" class="link">politique de confidentialité</a></span>
                    </label>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-user-plus"></i>
                    Créer mon compte aide-soignant
                </button>
            </form>

            <!-- Footer -->
            <div class="form-footer">
                <p>Vous avez déjà un compte ? 
                    <a href="${pageContext.request.contextPath}/" class="link-login">Se connecter</a>
                </p>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/inscription.js"></script>
</body>
</html>