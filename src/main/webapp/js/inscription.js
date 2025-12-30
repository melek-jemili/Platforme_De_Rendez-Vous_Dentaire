
document.querySelectorAll('input[name="accountType"]').forEach(radio => {
    radio.addEventListener('change', function() {
        // Masquer tous les formulaires
        document.querySelectorAll('.inscription-form').forEach(form => {
            form.classList.remove('active');
        });
        
        if (this.value === 'patient') {
            document.getElementById('form-patient').classList.add('active');
        } else {
            document.getElementById('form-aidesoignant').classList.add('active');
        }
    });
});


document.querySelectorAll('.toggle-password').forEach(button => {
    button.addEventListener('click', function() {
        const targetId = this.dataset.target;
        const input = document.getElementById(targetId);
        const icon = this.querySelector('i');
        
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });
});


const formPatient = document.getElementById('form-patient');
if (formPatient) {
    formPatient.addEventListener('submit', function(e) {
        const password = document.getElementById('mdpP').value;
        const confirmPassword = document.getElementById('mdpP-confirm').value;
        const nom = document.getElementById('nomP').value.trim();
        const prenom = document.getElementById('prenomP').value.trim();
        const email = document.getElementById('emailP').value.trim();
        const dateN = document.getElementById('dateNP').value;
        const sexe = document.getElementById('sexeP').value;
        

        if (!nom || !prenom || !email || !dateN || !sexe) {
            e.preventDefault();
            showAlert('Veuillez remplir tous les champs obligatoires !', 'error');
            return false;
        }
        

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            showAlert('Veuillez entrer une adresse email valide !', 'error');
            return false;
        }
        

        if (password.length < 8) {
            e.preventDefault();
            showAlert('Le mot de passe doit contenir au moins 8 caractères !', 'error');
            return false;
        }
        

        if (password !== confirmPassword) {
            e.preventDefault();
            showAlert('Les mots de passe ne correspondent pas !', 'error');
            return false;
        }
        

        const today = new Date();
        const birthDate = new Date(dateN);
        if (birthDate >= today) {
            e.preventDefault();
            showAlert('La date de naissance ne peut pas être dans le futur !', 'error');
            return false;
        }
        

        const age = Math.floor((today - birthDate) / (365.25 * 24 * 60 * 60 * 1000));
        if (age < 13) {
            e.preventDefault();
            showAlert('Vous devez avoir au moins 13 ans pour créer un compte !', 'error');
            return false;
        }
        

        const acceptTerms = formPatient.querySelector('input[name="acceptTerms"]');
        if (!acceptTerms.checked) {
            e.preventDefault();
            showAlert('Vous devez accepter les conditions d\'utilisation !', 'error');
            return false;
        }
        

        showLoader(e.submitter);
    });
}


const formAideSoignant = document.getElementById('form-aidesoignant');
if (formAideSoignant) {
    formAideSoignant.addEventListener('submit', function(e) {
        const password = document.getElementById('mdpP').value;
        const confirmPassword = document.getElementById('mdpP-confirm').value;
        const nom = document.getElementById('nom').value.trim();
        const prenom = document.getElementById('prénom').value.trim();
        const email = document.getElementById('emailP').value.trim();
        const telephone = document.getElementById('telephone').value.trim();
        const dateN = document.getElementById('dateNP').value;
        const sexe = document.getElementById('sexeP').value;
        const diplome = document.getElementById('diplome').value.trim();
        const adresse = document.getElementById('adresse').value.trim();
        

        if (!nom || !prenom || !email || !telephone || !dateN || !sexe || !diplome || !adresse) {
            e.preventDefault();
            showAlert('Veuillez remplir tous les champs obligatoires !', 'error');
            return false;
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            showAlert('Veuillez entrer une adresse email valide !', 'error');
            return false;
        }
        

        const phoneRegex = /^\d{8}$/;
        if (!phoneRegex.test(telephone)) {
            e.preventDefault();
            showAlert('Le numéro de téléphone doit contenir 8 chiffres !', 'error');
            return false;
        }
        

        if (password.length < 8) {
            e.preventDefault();
            showAlert('Le mot de passe doit contenir au moins 8 caractères !', 'error');
            return false;
        }
        

        if (password !== confirmPassword) {
            e.preventDefault();
            showAlert('Les mots de passe ne correspondent pas !', 'error');
            return false;
        }
        

        const today = new Date();
        const birthDate = new Date(dateN);
        if (birthDate >= today) {
            e.preventDefault();
            showAlert('La date de naissance ne peut pas être dans le futur !', 'error');
            return false;
        }
        

        const age = Math.floor((today - birthDate) / (365.25 * 24 * 60 * 60 * 1000));
        if (age < 18) {
            e.preventDefault();
            showAlert('Vous devez avoir au moins 18 ans pour créer un compte aide-soignant !', 'error');
            return false;
        }

        const acceptTerms = formAideSoignant.querySelector('input[name="acceptTerms"]');
        if (!acceptTerms.checked) {
            e.preventDefault();
            showAlert('Vous devez accepter les conditions d\'utilisation !', 'error');
            return false;
        }
        

        showLoader(e.submitter);
    });
}


function showAlert(message, type) {

    const existingAlerts = document.querySelectorAll('.alert');
    existingAlerts.forEach(alert => alert.remove());
    

    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.innerHTML = `
        <i class="fas fa-${type === 'error' ? 'exclamation-circle' : 'check-circle'}"></i>
        ${message}
    `;
    

    const container = document.querySelector('.inscription-container');
    const titleSection = document.querySelector('.title-section');
    container.insertBefore(alertDiv, titleSection.nextSibling);
    

    alertDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
    
    
    setTimeout(() => {
        alertDiv.style.animation = 'fadeOut 0.5s ease-out';
        setTimeout(() => alertDiv.remove(), 500);
    }, 5000);
}


function showLoader(button) {
    if (button) {
        button.disabled = true;
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Création en cours...';
    }
}


const style = document.createElement('style');
style.textContent = `
    @keyframes fadeOut {
        from {
            opacity: 1;
            transform: translateY(0);
        }
        to {
            opacity: 0;
            transform: translateY(-10px);
        }
    }
`;
document.head.appendChild(style);