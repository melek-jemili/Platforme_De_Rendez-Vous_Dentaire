<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Rendez-vous</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/rendezvous/addrv.css">
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
            <a href="${pageContext.request.contextPath}/patient/rendezvous">
                Rendez-vous
            </a>
            <i class="fas fa-chevron-right"></i>
            <span>Nouveau</span>
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

        <!-- Form Card -->
        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-calendar-plus"></i>
                <h1>Créer un Rendez-vous</h1>
                <p>Remplissez les informations ci-dessous pour planifier votre rendez-vous</p>
            </div>

            <div class="form-content">
                <!-- Info Box -->
                <div class="info-box">
                    <i class="fas fa-lightbulb"></i>
                    <div class="info-box-content">
                        <h4>Conseils pour votre rendez-vous</h4>
                        <p>Assurez-vous de choisir une date et une heure qui vous conviennent. Vous recevrez une confirmation par email une fois votre demande validée par le dentiste.</p>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/rendezvous/add" method="post">
                    
                    <!-- Informations du Rendez-vous -->
                    <h3 class="section-title">
                        <i class="fas fa-calendar-alt"></i>
                        Date et Heure
                    </h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-calendar-day"></i>
                                Date du rendez-vous
                                <span class="required">*</span>
                            </label>
                            <input type="date" name="dateRv" id="dateRv" required 
                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-clock"></i>
                                Heure du rendez-vous
                                <span class="required">*</span>
                            </label>
                            <input type="time" name="heureRv" id="heureRv" required 
                                   min="08:00" max="18:00">
                            <div class="time-slot-helper">
                                <span class="time-slot" onclick="setTime('09:00')">09:00</span>
                                <span class="time-slot" onclick="setTime('10:00')">10:00</span>
                                <span class="time-slot" onclick="setTime('11:00')">11:00</span>
                                <span class="time-slot" onclick="setTime('14:00')">14:00</span>
                                <span class="time-slot" onclick="setTime('15:00')">15:00</span>
                                <span class="time-slot" onclick="setTime('16:00')">16:00</span>
                            </div>
                        </div>
                    </div>

                    <!-- Choix du Dentiste -->
                    <h3 class="section-title">
                        <i class="fas fa-user-md"></i>
                        Sélection du Dentiste
                    </h3>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-stethoscope"></i>
                            Choisir un dentiste
                            <span class="required">*</span>
                        </label>
                        <select name="idD" id="idD" required onchange="updateDentistInfo()">
                            <option value="">-- Sélectionner un dentiste --</option>
                            <c:forEach items="${dentistes}" var="d">
                                <option value="${d.idD}" 
                                        data-nom="${d.nomD}" 
                                        data-prenom="${d.prenomD}"
                                        data-specialite="${d.specialiteD}">
                                    Dr. ${d.nomD} ${d.prenomD} - ${d.specialiteD}
                                </option>
                            </c:forEach>
                        </select>
                        <div id="dentistInfo" style="display: none;" class="dentist-info">
                            <div class="dentist-avatar">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <div>
                                <strong id="dentistName"></strong>
                                <div style="font-size: 0.9rem; color: #666;" id="dentistSpeciality"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Détails -->
                    <h3 class="section-title">
                        <i class="fas fa-file-medical"></i>
                        Détails du Rendez-vous
                    </h3>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-info-circle"></i>
                            Statut
                        </label>
                        <input type="text" name="statutRv" id="statutRv" 
                               value="En attente" readonly 
                               style="background: #f5f5f5; cursor: not-allowed;">
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-align-left"></i>
                            Motif de consultation / Détails
                        </label>
                        <textarea name="detailsRv" id="detailsRv" 
                                  placeholder="Décrivez le motif de votre consultation (ex: consultation de routine, douleur dentaire, détartrage, etc.)"></textarea>
                    </div>

                    <!-- Champ caché pour le patient connecté -->
                    <input type="hidden" name="idP" value="${sessionScope.patient.idP}">

                    <!-- Boutons -->
                    <div class="btn-group">
                    <c:choose>
                        <c:when test="${not empty sessionScope.dentiste}">
                            <a href="${pageContext.request.contextPath}/dentiste/dashboard" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Annuler
                            </a>
                        </c:when>
                        <c:when test="${not empty sessionScope.aidesoignant}">
                            <a href="${pageContext.request.contextPath}/aidesoignant/dashboard" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Annuler
                            </a>
                        </c:when>
                        <c:when test="${not empty sessionScope.patient}">
                        <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-cancel">
                            <i class="fas fa-times"></i>
                            Annuler
                        </a>
                        </c:when>
                        
                    </c:choose>
                        
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-calendar-check"></i>
                            Créer le Rendez-vous
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        
        function setTime(time) {
            document.getElementById('heureRv').value = time;
        }

        
        function updateDentistInfo() {
            const select = document.getElementById('idD');
            const option = select.options[select.selectedIndex];
            const infoDiv = document.getElementById('dentistInfo');
            
            if (option.value) {
                const nom = option.getAttribute('data-nom');
                const prenom = option.getAttribute('data-prenom');
                const specialite = option.getAttribute('data-specialite');
                
                document.getElementById('dentistName').textContent = `Dr. ${nom} ${prenom}`;
                document.getElementById('dentistSpeciality').textContent = specialite;
                infoDiv.style.display = 'flex';
            } else {
                infoDiv.style.display = 'none';
            }
        }

       
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('dateRv').setAttribute('min', today);

       
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);


        document.querySelector('form').addEventListener('submit', function(e) {
            const dateInput = document.getElementById('dateRv');
            const timeInput = document.getElementById('heureRv');
            const dentistSelect = document.getElementById('idD');
            
            if (!dateInput.value || !timeInput.value || !dentistSelect.value) {
                e.preventDefault();
                alert('Veuillez remplir tous les champs obligatoires.');
                return false;
            }
            
            
            const selectedDate = new Date(dateInput.value + 'T' + timeInput.value);
            const now = new Date();
            
            if (selectedDate < now) {
                e.preventDefault();
                alert('Vous ne pouvez pas choisir une date et heure dans le passé.');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>