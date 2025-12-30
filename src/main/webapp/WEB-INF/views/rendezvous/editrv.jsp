<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier le Rendez-vous</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/rendezvous/edit.css">
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
            <a href="${pageContext.request.contextPath}/patient/dashboard#rendezvous">
                Rendez-vous
            </a>
            <i class="fas fa-chevron-right"></i>
            <span>Modifier</span>
        </div>

        <!-- Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Form Card -->
        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-edit"></i>
                <h1>Modifier le Rendez-vous</h1>
                <p>Mettez à jour les informations de votre rendez-vous</p>
            </div>

            <div class="form-content">
                <!-- Info Box -->
                <div class="info-box">
                    <i class="fas fa-info-circle"></i>
                    <div class="info-box-content">
                        <h4>Information importante</h4>
                        <p>Assurez-vous que les modifications sont correctes avant de sauvegarder. Vous recevrez une notification une fois les changements validés.</p>
                    </div>
                </div>

                <!-- Current Information -->
                <div class="current-info">
                    <h4>
                        <i class="fas fa-calendar-check"></i>
                        Informations actuelles
                    </h4>
                    <div class="current-info-grid">
                        <div class="current-info-item">
                            <span class="current-info-label">Date actuelle</span>
                            <span class="current-info-value">
                                <fmt:formatDate value="${rdv.dateRv}" pattern="dd/MM/yyyy" />
                            </span>
                        </div>
                        <div class="current-info-item">
                            <span class="current-info-label">Heure actuelle</span>
                            <span class="current-info-value">${rdv.heureRv}</span>
                        </div>
                        <div class="current-info-item">
                            <span class="current-info-label">Dentiste actuel</span>
                            <span class="current-info-value">Dr. ${rdv.dentiste.nomD}</span>
                        </div>
                        <div class="current-info-item">
                            <span class="current-info-label">Statut</span>
                            <span class="current-info-value">${rdv.statutRv}</span>
                        </div>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/rendezvous/update" method="post">
                    
                    <!-- Hidden ID -->
                    <input type="hidden" name="idRv" value="${rdv.idRv}">

                    <!-- Date et Heure -->
                    <h3 class="section-title">
                        <i class="fas fa-calendar-alt"></i>
                        Date et Heure
                    </h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-calendar-day"></i>
                                Nouvelle Date
                                <span class="required">*</span>
                            </label>
                            <input type="date" name="dateRv" id="dateRv" value="${rdv.dateRv}" required
                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-clock"></i>
                                Nouvelle Heure
                                <span class="required">*</span>
                            </label>
                            <input type="time" name="heureRv" id="heureRv" value="${rdv.heureRv}" required
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

                    <!-- Dentiste -->
                    <h3 class="section-title">
                        <i class="fas fa-user-md"></i>
                        Dentiste
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
                                        data-specialite="${d.specialiteD}"
                                        <c:if test="${d.idD == rdv.dentiste.idD}">selected</c:if>>
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

                    <!-- Statut et Détails -->
                    <h3 class="section-title">
                        <i class="fas fa-file-medical"></i>
                        Statut et Détails
                    </h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-info-circle"></i>
                                Statut
                                <span class="required">*</span>
                            </label>
                            <select name="statutRv" id="statutRv" required>
                                <option value="En attente" ${rdv.statutRv == 'En attente' ? 'selected' : ''}>En attente</option>
                                <option value="Confirmé" ${rdv.statutRv == 'Confirmé' ? 'selected' : ''}>Confirmé</option>
                                <option value="Annulé" ${rdv.statutRv == 'Annulé' ? 'selected' : ''}>Annulé</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-align-left"></i>
                            Motif de consultation / Détails
                        </label>
                        <textarea name="detailsRv" id="detailsRv" 
                                  placeholder="Décrivez le motif de votre consultation ou ajoutez des notes...">${rdv.detailsRv}</textarea>
                    </div>

                    <!-- Boutons -->
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-cancel">
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

       
        window.addEventListener('load', function() {
            const select = document.getElementById('idD');
            if (select.value) {
                updateDentistInfo();
            }
        });

      
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
                const confirm = window.confirm('La date et l\'heure sélectionnées sont dans le passé. Voulez-vous continuer ?');
                if (!confirm) {
                    e.preventDefault();
                    return false;
                }
            }
            
            return true;
        });

        
        document.querySelectorAll('input, select, textarea').forEach(input => {
            const originalValue = input.value;
            input.addEventListener('change', function() {
                if (this.value !== originalValue) {
                    this.style.borderColor = '#f39c12';
                    this.style.backgroundColor = '#fff9e6';
                } else {
                    this.style.borderColor = '#e0e0e0';
                    this.style.backgroundColor = 'white';
                }
            });
        });
    </script>
</body>
</html>