pipeline {
    agent any
    
    options {
        timeout(time: 10, unit: 'MINUTES')
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Descargando código...'
                retry(3) {
                    git branch: 'main', 
                        url: 'https://github.com/PurosBrothers/simple-django-app-taller2.git'
                }
            }
        }
        
        stage('Lint') {
            steps {
                echo 'Ejecutando pylint...'
                sh '''
                    pip3 -m pip install pylint
                    find . -name "*.py" -not -path "./venv/*" -not -path "./.venv/*" | xargs python3 -m pylint --exit-zero || true
                '''
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Desplegando aplicación...'
                sh '''
                    docker cp . django-app:/app/
                    docker exec django-app pip install -r requirements.txt
                    docker exec django-app python manage.py migrate
                    docker exec django-app pkill -f "python manage.py runserver" || true
                    docker exec -d django-app sh -c "python manage.py runserver 0.0.0.0:8000 > /tmp/django.log 2>&1"
                    echo "Aplicación desplegada en http://localhost:8000"
                '''
            }
        }
    }
}