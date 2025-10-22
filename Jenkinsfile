pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/PurosBrothers/simple-django-app-taller2.git'
            }
        }

        stage('Lint') {
            steps {
                sh 'pip3 install --break-system-packages pylint && find . -name "*.py" -not -path "./venv/*" -not -path "./.venv/*" | xargs python3 -m pylint --exit-zero || true'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker stop django-app || true
                    docker rm django-app || true
                    docker run -d --name django-app -p 8000:8000 django-app:latest
                    sleep 10
                    docker exec django-app python manage.py migrate
                '''
            }
        }
    }
}
