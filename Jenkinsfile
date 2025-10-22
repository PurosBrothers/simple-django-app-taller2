pipeline {
    agent any

    environment {
        APP_NAME = "simple-django-app-taller2"
        REPO_URL = "https://github.com/PurosBrothers/simple-django-app-taller2.git"
        PYTHON = "python3"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'clonando el repositorio...'
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('instalar dependencias') {
            steps {
                echo 'Django'
                sh '''
                    ${PYTHON} -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install django
                '''
            }
        }

        stage('Analisis estático con pylint') {
            steps {
                echo '🔍 Ejecutando pylint...'
                sh '''
                    . venv/bin/activate
                    pip install pylint
                    find . -name "*.py" | xargs pylint || true
                '''
            }
        }

        stage('Ejecutar pruebas del proyecto') {
            steps {
                echo 'Ejecutando pruebas'
                sh '''
                    . venv/bin/activate
                    ${PYTHON} manage.py test || true
                '''
            }
        }

        stage('Construir imagen Docker') {
            steps {
                echo 'Construyendo docker'
                sh '''
                    docker build -t ${APP_NAME}:latest .
                '''
            }
        }

        stage('Desplegar aplicación') {
            steps {
                echo 'Desplegando aplicación Docker Compose...'
                sh '''
                    if [ -f docker-compose.yml ]; then
                        docker-compose down || true
                        docker-compose up -d --build
                    else
                        echo "No se encontró docker-compose.yml, ejecutando servidor local..."
                        . venv/bin/activate
                        nohup ${PYTHON} manage.py runserver 0.0.0.0:8000 &
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completado exitosamente.'
        }
        failure {
            echo '❌ Falló el pipeline. Revisa los logs para más detalles.'
        }
    }
}
