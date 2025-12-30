
document.querySelectorAll('.nav-item').forEach(item => {
    item.addEventListener('click', function(e) {
        e.preventDefault();
        
       
        document.querySelectorAll('.nav-item').forEach(nav => {
            nav.classList.remove('active');
        });
        
        
        this.classList.add('active');
        
       
        const sectionName = this.dataset.section;
        showSection(sectionName);
    });
});


function showSection(sectionName) {
   
    document.querySelectorAll('.content-section').forEach(section => {
        section.classList.remove('active');
    });
    
    
    const targetSection = document.getElementById(sectionName + '-section');
    if (targetSection) {
        targetSection.classList.add('active');
    }
    
   
    document.querySelectorAll('.nav-item').forEach(nav => {
        nav.classList.remove('active');
        if (nav.dataset.section === sectionName) {
            nav.classList.add('active');
        }
    });
}


function toggleModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.toggle('active');
    }
}


document.querySelectorAll('.modal').forEach(modal => {
    modal.addEventListener('click', function(e) {
        if (e.target === this) {
            this.classList.remove('active');
        }
    });
});


function updateDateTime() {
    const now = new Date();
    const options = { 
        weekday: 'long', 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric' 
    };
    const dateString = now.toLocaleDateString('fr-FR', options);
    
    const dateElement = document.getElementById('current-date');
    if (dateElement) {
        dateElement.textContent = dateString;
    }
}

updateDateTime();


setTimeout(() => {
    document.querySelectorAll('.alert').forEach(alert => {
        alert.style.animation = 'slideOut 0.5s ease-out';
        setTimeout(() => alert.remove(), 500);
    });
}, 5000);


document.querySelectorAll('.btn-delete').forEach(btn => {
    btn.addEventListener('click', function(e) {
        if (!confirm('Êtes-vous sûr de vouloir supprimer cet élément ?')) {
            e.preventDefault();
        }
    });
});