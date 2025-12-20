<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Rendez-vous</title>
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

        .form-header p {
            font-size: 1rem;
            opacity: 0.9;
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
        .form-group input[type="date"],
        .form-group input[type="time"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
            font-family: inherit;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group select {
            cursor: pointer;
            background-color: white;
        }

        .info-box {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            border-left: 4px solid #667eea;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .info-box i {
            color: #667eea;
            font-size: 1.3rem;
            margin-top: 2px;
        }

        .info-box-content h4 {
            color: #333;
            font-size: 1rem;
            margin-bottom: 5px;
        }

        .info-box-content p {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .dentist-info {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
            margin-top: 10px;
        }

        .dentist-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
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

        .alert-success {
            background: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
        }

        .alert-error {
            background: #f8d7da;
            border-left: 4px solid #dc3545;
            color: #721c24;
        }

        .time-slot-helper {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .time-slot {
            padding: 8px 15px;
            background: #f8f9fa;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
        }

        .time-slot:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
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

            .time-slot-helper {
                justify-content: center;
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
                        <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-cancel">
                            <i class="fas fa-times"></i>
                            Annuler
                        </a>
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
        // Set time from helper buttons
        function setTime(time) {
            document.getElementById('heureRv').value = time;
        }

        // Update dentist info display
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

        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('dateRv').setAttribute('min', today);

        // Auto-hide alerts
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);

        // Validate form before submit
        document.querySelector('form').addEventListener('submit', function(e) {
            const dateInput = document.getElementById('dateRv');
            const timeInput = document.getElementById('heureRv');
            const dentistSelect = document.getElementById('idD');
            
            if (!dateInput.value || !timeInput.value || !dentistSelect.value) {
                e.preventDefault();
                alert('Veuillez remplir tous les champs obligatoires.');
                return false;
            }
            
            // Check if date is not in the past
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