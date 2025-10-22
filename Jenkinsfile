pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Jenkins descarga el código actualizado
                git url: 'https://github.com/PurosBrothers/simple-django-app-taller2.git'
            }
        }
        
        stage('Lint') {
            steps {
                // Jenkins ejecuta pylint
                sh 'pip install pylint'
                sh 'pylint **/*.py || true'
            }
        }
        
        stage('Deploy') {
            steps {
                // Jenkins RECONSTRUYE solo Django
                sh 'docker-compose up -d --build django_app'
                // Esto reconstruye y reinicia SOLO django_app
            }
        }
    }
}