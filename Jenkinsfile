pipeline {
    agent any

    environment {
        IMAGE_NAME = "sgcameron/demo-app"
        DOCKERHUB_CREDENTIALS = "dockerhub-creds"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/SGCameron/Java-maven-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build Docker image only if Docker is accessible
                    if (fileExists('Dockerfile')) {
                        sh "docker build -t ${IMAGE_NAME} ."
                    } else {
                        echo 'Dockerfile not found, skipping Docker build.'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Run the container if Docker is accessible
                    if (fileExists('Dockerfile')) {
                        sh "docker run -d -p 8081:8080 ${IMAGE_NAME}"
                    } else {
                        echo 'Dockerfile not found, skipping deployment.'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
