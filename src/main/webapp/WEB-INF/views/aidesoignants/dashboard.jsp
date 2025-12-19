<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Aide-Soignant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-as.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<%
    // Vérifier que l'aide-soignant est connecté
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>

<div class="dashboard-container">
    
    <!-- Sidebar Navigation -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="logo">
                <i class="fas fa-user-nurse"></i>
                <h2>Aide-Soignant<span>Pro</span></h2>
            </div>
        </div>

        <div class="user-info">
            <div class="avatar">
                <c:choose>
                    <c:when test="${not empty sessionScope.user.photoP}">
                        <img src="${sessionScope.user.photoP}" alt="Photo">
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user-circle"></i>
                    </c:otherwise>
                </c:choose>
            </div>
            <h3>${sessionScope.user.nom} ${sessionScope.user.prenom}</h3>
            <p>${sessionScope.user.diplome}</p>
        </div>

        <nav class="sidebar-nav">
            <a href="#dashboard" class="nav-item active" data-section="dashboard">
                <i class="fas fa-home"></i>
                <span>Tableau de bord</span>
            </a>
            <a href="#rendezvous" class="nav-item" data-section="rendezvous">
                <i class="fas fa-calendar-alt"></i>
                <span>Liste des RDV</span>
            </a>
            <a href="#publications" class="nav-item" data-section="publications">
                <i class="fas fa-bullhorn"></i>
                <span>Publications</span>
            </a>
            <a href="#services" class="nav-item" data-section="services">
                <i class="fas fa-briefcase-medical"></i>
                <span>Services Médicaux</span>
            </a>
            <a href="#profile" class="nav-item" data-section="profile">
                <i class="fas fa-user"></i>
                <span>Mon Profil</span>
            </a>
        </nav>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                <span>Se déconnecter</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        
        <!-- Header -->
        <header class="content-header">
            <h1>Bienvenue, ${sessionScope.user.prenom} !</h1>
            <div class="header-actions">
                <div class="notifications">
                    <button class="btn-icon">
                        <i class="fas fa-bell"></i>
                        <span class="badge">3</span>
                    </button>
                </div>
                <div class="date-time">
                    <i class="fas fa-calendar"></i>
                    <span id="current-date"></span>
                </div>
            </div>
        </header>

        <!-- Messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${sessionScope.successMessage}
            </div>
            <% session.removeAttribute("successMessage"); %>
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${sessionScope.errorMessage}
            </div>
            <% session.removeAttribute("errorMessage"); %>
        </c:if>

        <!-- Section: Dashboard -->
        <section id="dashboard-section" class="content-section active">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${totalRdv}</h3>
                        <p>RDV Total</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${rdvEnAttente}</h3>
                        <p>En attente</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon orange">
                        <i class="fas fa-newspaper"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${totalPublications}</h3>
                        <p>Publications</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon purple">
                        <i class="fas fa-briefcase-medical"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${totalServices}</h3>
                        <p>Services</p>
                    </div>
                </div>
            </div>

            <div class="quick-actions">
                <h2><i class="fas fa-bolt"></i> Actions Rapides</h2>
                <div class="actions-grid">
                    <button class="action-card" onclick="showSection('publications')">
                        <i class="fas fa-plus-circle"></i>
                        <span>Nouvelle Publication</span>
                    </button>
                    <button class="action-card" onclick="showSection('services')">
                        <i class="fas fa-briefcase-medical"></i>
                        <span>Ajouter un Service</span>
                    </button>
                    <button class="action-card" onclick="showSection('rendezvous')">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Voir les RDV</span>
                    </button>
                    <button class="action-card" onclick="showSection('profile')">
                        <i class="fas fa-user-edit"></i>
                        <span>Modifier Profil</span>
                    </button>
                </div>
            </div>
        </section>

        <!-- Section: Rendez-vous -->
        <section id="rendezvous-section" class="content-section">
            <div class="section-header">
                <h2><i class="fas fa-calendar-alt"></i> Liste des Rendez-vous</h2>
                <button class="btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/rendezvous/list'">
                    <i class="fas fa-sync-alt"></i> Actualiser
                </button>
            </div>

            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Patient</th>
                            <th>Dentiste</th>
                            <th>Date</th>
                            <th>Heure</th>
                            <th>Statut</th>
                            <th>Détails</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${rendezvousList}" var="rdv">
                            <tr>
                                <td>#${rdv.numRv}</td>
                                <td>${rdv.patient.nomP} ${rdv.patient.prenomP}</td>
                                <td>Dr. ${rdv.dentiste.nomD}</td>
                                <td>${rdv.dateRv}</td>
                                <td>${rdv.heureRv}</td>
                                <td>
                                    <span class="badge badge-${rdv.statutRv == 'Confirmé' ? 'success' : rdv.statutRv == 'En attente' ? 'warning' : 'danger'}">
                                        ${rdv.statutRv}
                                    </span>
                                </td>
                                <td>${rdv.detailsRv}</td>
                                <td>
                                    <button class="btn-icon" title="Voir détails">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Section: Publications -->
        <section id="publications-section" class="content-section">
            <div class="section-header">
                <h2><i class="fas fa-bullhorn"></i> Publications</h2>
                <button class="btn-primary" onclick="toggleModal('modalPublication')">
                    <i class="fas fa-plus"></i> Nouvelle Publication
                </button>
            </div>

            <div class="publications-grid">
                <c:forEach items="${publicationsList}" var="pub">
                    <div class="publication-card">
                        <div class="pub-header">
                            <h3>${pub.titre}</h3>
                            <span class="pub-date">${pub.dateCreation}</span>
                        </div>
                        <div class="pub-content">
                            <p>${pub.contenu}</p>
                        </div>
                        <div class="pub-footer">
                            <button class="btn-edit">
                                <i class="fas fa-edit"></i> Modifier
                            </button>
                            <button class="btn-delete">
                                <i class="fas fa-trash"></i> Supprimer
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- Section: Services Médicaux -->
        <section id="services-section" class="content-section">
            <div class="section-header">
                <h2><i class="fas fa-briefcase-medical"></i> Services Médicaux</h2>
                <button class="btn-primary" onclick="toggleModal('modalService')">
                    <i class="fas fa-plus"></i> Nouveau Service
                </button>
            </div>

            <div class="services-grid">
                <c:forEach items="${servicesList}" var="service">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-stethoscope"></i>
                        </div>
                        <h3>${service.nomService}</h3>
                        <p>${service.description}</p>
                        <div class="service-info">
                            <span><i class="fas fa-clock"></i> ${service.duree} min</span>
                            <span><i class="fas fa-tag"></i> ${service.prix} DT</span>
                        </div>
                        <div class="service-actions">
                            <button class="btn-edit">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-delete">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- Section: Profil -->
        <section id="profile-section" class="content-section">
            <div class="section-header">
                <h2><i class="fas fa-user"></i> Mon Profil</h2>
            </div>

            <div class="profile-container">
                <form action="${pageContext.request.contextPath}/aidesoignants/update" method="post" class="profile-form">
                    <input type="hidden" name="idAS" value="${sessionScope.user.idAS}">

                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Nom</label>
                            <input type="text" name="nom" value="${sessionScope.user.nom}" required>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Prénom</label>
                            <input type="text" name="prénom" value="${sessionScope.user.prenom}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-envelope"></i> Email</label>
                            <input type="email" name="emailP" value="${sessionScope.user.emailP}" required>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-phone"></i> Téléphone</label>
                            <input type="tel" name="telephone" value="${sessionScope.user.telephone}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-map-marker-alt"></i> Adresse</label>
                        <input type="text" name="adresse" value="${sessionScope.user.adresse}">
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-graduation-cap"></i> Diplôme</label>
                            <input type="text" name="diplome" value="${sessionScope.user.diplome}">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-venus-mars"></i> Sexe</label>
                            <select name="sexeP">
                                <option value="M" ${sessionScope.user.sexeP == 'M' ? 'selected' : ''}>Masculin</option>
                                <option value="F" ${sessionScope.user.sexeP == 'F' ? 'selected' : ''}>Féminin</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-lock"></i> Nouveau mot de passe (laisser vide si inchangé)</label>
                        <input type="password" name="mdpP" placeholder="••••••••">
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> Enregistrer les modifications
                    </button>
                </form>
            </div>
        </section>

    </main>
</div>

<!-- Modal Nouvelle Publication -->
<div id="modalPublication" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Nouvelle Publication</h2>
            <button class="close-modal" onclick="toggleModal('modalPublication')">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <form action="${pageContext.request.contextPath}/publications/add" method="post">
            <input type="hidden" name="idAS" value="${sessionScope.user.idAS}">
            
            <div class="form-group">
                <label>Titre</label>
                <input type="text" name="titre" required>
            </div>
            
            <div class="form-group">
                <label>Contenu</label>
                <textarea name="contenu" rows="6" required></textarea>
            </div>
            
            <button type="submit" class="btn-primary">
                <i class="fas fa-paper-plane"></i> Publier
            </button>
        </form>
    </div>
</div>

<!-- Modal Nouveau Service -->
<div id="modalService" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Nouveau Service Médical</h2>
            <button class="close-modal" onclick="toggleModal('modalService')">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <form action="${pageContext.request.contextPath}/services/add" method="post">
            <input type="hidden" name="idAS" value="${sessionScope.user.idAS}">
            
            <div class="form-group">
                <label>Nom du service</label>
                <input type="text" name="nomService" required>
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="4" required></textarea>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Durée (minutes)</label>
                    <input type="number" name="duree" required>
                </div>
                <div class="form-group">
                    <label>Prix (DT)</label>
                    <input type="number" name="prix" step="0.01" required>
                </div>
            </div>
            
            <button type="submit" class="btn-primary">
                <i class="fas fa-plus"></i> Ajouter le service
            </button>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/dashboard-as.js"></script>
</body>
</html>