
document.querySelectorAll('.tab-btn').forEach(button => {
    button.addEventListener('click', function() {
        // Retirer la classe active de tous les boutons
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('active');
        });
        
        
        this.classList.add('active');
        
        
        document.querySelectorAll('.login-form').forEach(form => {
            form.classList.remove('active');
        });
        
        
        const tabType = this.dataset.tab;
        document.getElementById('form-' + tabType).classList.add('active');
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