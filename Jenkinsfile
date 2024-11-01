pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')  
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/soufalami19/mod17-act1.git'  
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
                    def container = docker.image("souf12/eoi-modulo17:latest").run()
                    container.stop()
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('', 'DOCKERHUB_CREDENTIALS') {
                        docker.image("souf12/eoi-modulo17").push()
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
} 

