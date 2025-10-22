pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'django-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/PurosBrothers/simple-django-app-taller2.git'
            }
        }

        stage('Lint') {
            steps {
                sh 'pylint app/ --output-format=text'
            }
        }

        stage('Build App Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} app/'
            }
        }

        stage('Deploy App') {
            steps {
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