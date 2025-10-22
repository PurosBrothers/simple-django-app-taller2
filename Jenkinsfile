pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Descargando código...'
                git branch: 'main', 
                    url: 'https://github.com/PurosBrothers/simple-django-app-taller2.git'
            }
        }
        
        stage('Lint') {
            steps {
                echo 'Ejecutando pylint...'
                sh '''
                    pip install pylint
                    find . -name "*.py" -not -path "./venv/*" -not -path "./.venv/*" | xargs pylint --exit-zero || true
                '''
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Desplegando aplicación...'
                sh '''
                    # Copiar código al contenedor Django
                    docker cp . django-app:/app/
                    
                    # Instalar dependencias
                    docker exec django-app pip install -r requirements.txt
                    
                    # Ejecutar migraciones
                    docker exec django-app python manage.py migrate
                    
                    # Matar proceso anterior si existe
                    docker exec django-app pkill -f "python manage.py runserver" || true
                    
                    # Iniciar servidor Django en background
                    docker exec -d django-app sh -c "python manage.py runserver 0.0.0.0:8000 > /tmp/django.log 2>&1"
                    
                    echo "Aplicación desplegada en http://localhost:8000"
                '''
            }
        }
    }
}