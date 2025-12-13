<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Plateforme Rendez-Vous Médical</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link rel="icon" type="image/ico" href="resources/images/logojee.ico">
</head>
<body>
    <!-- Background avec overlay -->
    <div class="background-overlay"></div>
    
    <!-- Container principal -->
    <div class="login-wrapper">
        <!-- Côté gauche - Information -->
        <div class="info-section">
            <div class="info-content">
                <div class="logo-section">
                    <i class="fas fa-heartbeat"></i>
                    <h1>Smile<span>Everyday</span></h1>
                </div>
                <h2>Bienvenue sur votre plateforme de rendez-vous médical</h2>
                <p>Gérez vos rendez-vous dentaires en toute simplicité</p>
                
                <div class="features">
                    <div class="feature-item">
                        <i class="fas fa-calendar-check"></i>
                        <span>Prise de rendez-vous en ligne 24/7</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-user-md"></i>
                        <span>Accès à votre dossier médical</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-bell"></i>
                        <span>Rappels automatiques</span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Côté droit - Formulaire -->
        <div class="form-section">
            <div class="form-container">
                <!-- Tabs pour choisir le type d'utilisateur -->
                <div class="tabs">
                    <button class="tab-btn active" data-tab="patient">
                        <i class="fas fa-user"></i>
                        Patient
                    </button>
                    <button class="tab-btn" data-tab="dentiste">
                        <i class="fas fa-user-md"></i>
                        Dentiste
                    </button>
                    <button class="tab-btn" data-tab="aidesoignant">
                        <i class="fas fa-user-nurse"></i>
                        Aide-soignant
                    </button>
                </div>

                <!-- Message d'erreur -->
                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        ${error}
                    </div>
                </c:if>

                <!-- Message de succès -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${success}
                    </div>
                </c:if>

                <!-- Formulaire Patient -->
                <form id="form-patient" class="login-form active" action="${pageContext.request.contextPath}/login" method="post">
                    <input type="hidden" name="userType" value="patient">
                    
                    <h3><i class="fas fa-sign-in-alt"></i> Connexion Patient</h3>
                    
                    <div class="form-group">
                        <label for="email-patient">
                            <i class="fas fa-envelope"></i>
                            Adresse Email
                        </label>
                        <input 
                            type="email" 
                            id="email-patient" 
                            name="email" 
                            placeholder="votre.email@exemple.com"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="password-patient">
                            <i class="fas fa-lock"></i>
                            Mot de passe
                        </label>
                        <div class="password-wrapper">
                            <input 
                                type="password" 
                                id="password-patient" 
                                name="password" 
                                placeholder="••••••••"
                                required>
                            <button type="button" class="toggle-password" data-target="password-patient">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-options">
                        <label class="checkbox-wrapper">
                            <input type="checkbox" name="remember">
                            <span>Se souvenir de moi</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/mot-de-passe-oublie" class="link-forgot">
                            Mot de passe oublié ?
                        </a>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-sign-in-alt"></i>
                        Se connecter
                    </button>

                    <div class="form-footer">
                        <p>Vous n'avez pas de compte ?</p>
                        <a href="${pageContext.request.contextPath}/patients/inscription" class="link-register">
                            Créer un compte patient
                        </a>
                    </div>
                </form>

                <!-- Formulaire Dentiste -->
                <form id="form-dentiste" class="login-form" action="${pageContext.request.contextPath}/login" method="post">
                    <input type="hidden" name="userType" value="dentiste">
                    
                    <h3><i class="fas fa-user-md"></i> Connexion Dentiste</h3>
                    
                    <div class="form-group">
                        <label for="email-dentiste">
                            <i class="fas fa-envelope"></i>
                            Adresse Email Professionnelle
                        </label>
                        <input 
                            type="email" 
                            id="email-dentiste" 
                            name="email" 
                            placeholder="dentiste@clinique.com"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="password-dentiste">
                            <i class="fas fa-lock"></i>
                            Mot de passe
                        </label>
                        <div class="password-wrapper">
                            <input 
                                type="password" 
                                id="password-dentiste" 
                                name="password" 
                                placeholder="••••••••"
                                required>
                            <button type="button" class="toggle-password" data-target="password-dentiste">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-options">
                        <label class="checkbox-wrapper">
                            <input type="checkbox" name="remember">
                            <span>Se souvenir de moi</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/mot-de-passe-oublie" class="link-forgot">
                            Mot de passe oublié ?
                        </a>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-sign-in-alt"></i>
                        Se connecter
                    </button>

                    <div class="form-footer">
                        <p>Accès réservé aux professionnels</p>
                    </div>
                </form>

                <!-- Formulaire Aide-soignant -->
                <form id="form-aidesoignant" class="login-form" action="${pageContext.request.contextPath}/login" method="post">
                    <input type="hidden" name="userType" value="aidesoignant">
                    
                    <h3><i class="fas fa-user-nurse"></i> Connexion Aide-soignant</h3>
                    
                    <div class="form-group">
                        <label for="email-aidesoignant">
                            <i class="fas fa-envelope"></i>
                            Adresse Email
                        </label>
                        <input 
                            type="email" 
                            id="email-aidesoignant" 
                            name="email" 
                            placeholder="aide.soignant@clinique.com"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="password-aidesoignant">
                            <i class="fas fa-lock"></i>
                            Mot de passe
                        </label>
                        <div class="password-wrapper">
                            <input 
                                type="password" 
                                id="password-aidesoignant" 
                                name="password" 
                                placeholder="••••••••"
                                required>
                            <button type="button" class="toggle-password" data-target="password-aidesoignant">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-options">
                        <label class="checkbox-wrapper">
                            <input type="checkbox" name="remember">
                            <span>Se souvenir de moi</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/mot-de-passe-oublie" class="link-forgot">
                            Mot de passe oublié ?
                        </a>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-sign-in-alt"></i>
                        Se connecter
                    </button>

                    <div class="form-footer">
                        <p>Accès réservé au personnel médical</p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>