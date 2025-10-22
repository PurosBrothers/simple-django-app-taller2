pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'django-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                // Replace with your actual repository URL
                git branch: 'main', url: 'https://github.com/PurosBrothers/simple-django-app-taller2.git'
            }
        }

        stage('Lint') {
            steps {
                // Run pylint on the entire app directory
                sh 'pylint app/ --output-format=text'
            }
        }

        stage('Build App Image') {
            steps {
                // Build the Django app Docker image
                sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} app/'
            }
        }

        stage('Deploy App') {
            steps {
                // Stop any existing container and run the new one
                sh '''
                docker stop django-app || true
                docker rm django-app || true
                docker run -d --name django-app -p 8000:8000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                '''
            }
        }
    }

    post {
        always {
            // Clean up dangling images
            sh 'docker image prune -f'
        }
        failure {
            echo 'Pipeline failed'
        }
        success {
            echo 'Pipeline succeeded'
        }
    }
}