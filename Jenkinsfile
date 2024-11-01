pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')  // Credenciales de DockerHub
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout Code') {
            steps {
                git 'https://github.com/soufalami19/mod17-act1.git'  
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("souf12/eoi-modulo17:latest")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    def container = docker.run("souf12/eoi-modulo17:latest")
                    container.stop()
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('', 'DOCKERHUB_CREDENTIALS') {
                        docker.image("souf12/eoi-modulo17:latest").push()
                    }
                }
            }
        }
    }


    post {
    success {
        echo "El pipeline se ejecutó correctamente."
    }
    failure {
        echo "El pipeline ha fallado."
    }
}


