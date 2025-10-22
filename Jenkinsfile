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
                    pip3 install --break-system-packages pylint
                    find . -name "*.py" -not -path "./venv/*" -not -path "./.venv/*" | xargs python3 -m pylint --exit-zero || true
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Desplegando aplicación...'
                sh '''
                    docker stop django-app || true
                    docker rm django-app || true
                    docker build -t django-app:latest -f cool_counters/Dockerfile cool_counters/
                    docker run -d --name django-app -p 8000:8000 django-app:latest
                    sleep 10
                    docker exec django-app python manage.py migrate
                    echo "Aplicación desplegada en http://localhost:8000"
                '''
            }
        }
    }
}
