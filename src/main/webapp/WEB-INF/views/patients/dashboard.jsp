<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Patient - ${sessionScope.patient.prenomP} ${sessionScope.patient.nomP}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="fas fa-tooth"></i>
            </div>
            <h2>Dental<span style="color: #667eea;">Care</span></h2>
            <p class="specialty">Espace Patient</p>
        </div>

        <div class="user-info">
            <div class="user-avatar">
                <c:choose>
                    <c:when test="${not empty sessionScope.patient.photoP}">
                        <img src="${pageContext.request.contextPath}/${sessionScope.patient.photoP}" alt="Photo">
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user"></i>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="user-name">${sessionScope.patient.prenomP} ${sessionScope.patient.nomP}</div>
            <div class="user-email">${sessionScope.patient.emailP}</div>
        </div>

        <nav class="nav-menu">
            <a href="#overview" class="nav-item active">
                <i class="fas fa-th-large"></i>
                <span>Tableau de bord</span>
            </a>
            <a href="#rendezvous" class="nav-item">
                <i class="fas fa-calendar-alt"></i>
                <span>Mes Rendez-vous</span>
            </a>
            <a href="${pageContext.request.contextPath}/patient/profile" class="nav-item">
                <i class="fas fa-user-circle"></i>
                <span>Mon Profil</span>
            </a>
        </nav>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Déconnexion
        </a>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <div class="dashboard-header">
            <div class="header-title">
                <h1>Bienvenue, ${sessionScope.patient.prenomP}</h1>
                <p>
                    <i class="far fa-calendar"></i>
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE dd MMMM yyyy" />
                </p>
            </div>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/rendezvous/add" class="btn btn-success">
                    <i class="fas fa-calendar-plus"></i>
                    Nouveau Rendez-vous
                </a>
                <a href="${pageContext.request.contextPath}/patient/profile" class="btn btn-info">
                    <i class="fas fa-user-edit"></i>
                    Mon Profil
                </a>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Stats Cards -->
        <div class="stats-grid" id="overview">
            <div class="stat-card">
                <div class="stat-icon rendezvous">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-info">
                    <h3>${fn:length(Rendezvous)}</h3>
                    <p>Rendez-vous Total</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon confirme">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <c:set var="confirmeCount" value="0"/>
                    <c:forEach var="rdv" items="${Rendezvous}">
                        <c:if test="${rdv.statutRv == 'Confirmé' || rdv.statutRv == 'confirme'}">
                            <c:set var="confirmeCount" value="${confirmeCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    <h3>${confirmeCount}</h3>
                    <p>Confirmés</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon en-attente">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <c:set var="attenteCount" value="0"/>
                    <c:forEach var="rdv" items="${Rendezvous}">
                        <c:if test="${rdv.statutRv == 'En attente' || rdv.statutRv == 'en-attente'}">
                            <c:set var="attenteCount" value="${attenteCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    <h3>${attenteCount}</h3>
                    <p>En Attente</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon annule">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-info">
                    <c:set var="annuleCount" value="0"/>
                    <c:forEach var="rdv" items="${Rendezvous}">
                        <c:if test="${rdv.statutRv == 'Annulé' || rdv.statutRv == 'annule'}">
                            <c:set var="annuleCount" value="${annuleCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    <h3>${annuleCount}</h3>
                    <p>Annulés</p>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <h2 class="section-subtitle">
            <i class="fas fa-bolt"></i> Actions Rapides
        </h2>
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/rendezvous/add" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-calendar-plus"></i>
                </div>
                <h3>Créer un Rendez-vous</h3>
                <p>Réservez un nouveau rendez-vous</p>
            </a>

            <a href="${pageContext.request.contextPath}/patients/update" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-user-edit"></i>
                </div>
                <h3>Modifier Profil</h3>
                <p>Mettre à jour vos informations</p>
            </a>

            <a href="${pageContext.request.contextPath}/patient/profile" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-id-card"></i>
                </div>
                <h3>Voir Profil</h3>
                <p>Consulter vos informations</p>
            </a>
        </div>

        <!-- Rendez-vous Section -->
        <div class="section" id="rendezvous">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-calendar-alt"></i>
                    Mes Rendez-vous
                </h2>
                <a href="${pageContext.request.contextPath}/rendezvous/add" class="btn btn-success">
                    <i class="fas fa-calendar-plus"></i>
                    Nouveau Rendez-vous
                </a>
            </div>

            <c:choose>
                <c:when test="${empty Rendezvous}">
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <p>Aucun rendez-vous pour le moment</p>
                        <a href="${pageContext.request.contextPath}/rendezvous/add" class="btn btn-primary" style="margin-top: 20px;">
                            <i class="fas fa-calendar-plus"></i>
                            Créer mon premier rendez-vous
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="rdv-grid">
                        <c:forEach items="${Rendezvous}" var="rdv">
                            <div class="rdv-card">
                                <div class="rdv-info">
                                    <div class="rdv-info-item">
                                        <i class="fas fa-calendar"></i>
                                        <strong>Date :</strong>
                                        <span>
                                            <fmt:formatDate value="${rdv.dateRv}" pattern="dd/MM/yyyy" />
                                        </span>
                                    </div>
                                    <div class="rdv-info-item">
                                        <i class="fas fa-clock"></i>
                                        <strong>Heure :</strong>
                                        <span>${rdv.heureRv}</span>
                                    </div>
                                    <div class="rdv-info-item">
                                        <i class="fas fa-user-md"></i>
                                        <strong>Dentiste :</strong>
                                        <span>Dr. ${rdv.dentiste.nomD} ${rdv.dentiste.prenomD}</span>
                                    </div>
                                    <c:if test="${not empty rdv.detailsRv}">
                                        <div class="rdv-info-item">
                                            <i class="fas fa-file-medical"></i>
                                            <strong>Détails :</strong>
                                            <span>${rdv.detailsRv}</span>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <span class="rdv-status ${fn:replace(rdv.statutRv, ' ', '-')}">${rdv.statutRv}</span>
                                
                                <!-- Boutons Actions -->
                                <div class="rdv-actions">
                                    <!-- Modifier -->
                                    <form action="${pageContext.request.contextPath}/rendezvous/update" method="get" style="display:inline;">
                                        <input type="hidden" name="idRv" value="${rdv.idRv}">
                                        <button type="submit" class="btn-edit">
                                            <i class="fas fa-edit"></i> Modifier
                                        </button>
                                    </form>
                                    <!-- Supprimer -->
                                    <form action="${pageContext.request.contextPath}/rendezvous/delete" method="get" style="display:inline;"
      onsubmit="return confirm('Voulez-vous vraiment supprimer ce rendez-vous ?');">
    <input type="hidden" name="idRv" value="${rdv.idRv}">
    <button type="submit" class="btn-delete">
        <i class="fas fa-trash-alt"></i> Supprimer
    </button>
</form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
        
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', function(e) {
                const href = this.getAttribute('href');
                if (href.startsWith('#')) {
                    e.preventDefault();
                    const target = document.querySelector(href);
                    if (target) {
                        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                    
                    
                    document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
                    this.classList.add('active');
                }
            });
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