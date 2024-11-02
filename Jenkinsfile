pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')  
        SONARQUBE_TOKEN = credentials('sonar')
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

        stage('Verify Credentials') {
            steps {
                script {
                    if (env.DOCKERHUB_CREDENTIALS_USR && env.DOCKERHUB_CREDENTIALS_PSW) {
                        echo "DockerHub credentials found: Username - ${env.DOCKERHUB_CREDENTIALS_USR}"
                        echo "DockerHub credentials found: Password - ${env.DOCKERHUB_CREDENTIALS_PSW}"
                    } else {
                        error("DockerHub credentials not found or invalid.")
                    }
                }
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

        stage('SonarQube Analysis') {
    steps {
        script {
            def scannerHome = tool 'SonarQube Scanner'
            withSonarQubeEnv('SonarQube') {
                // Ajoutez le curl de vérification
                sh 'curl -I -u "sqa_7fc8f5d524f125628e18365ed7ffee9c21b53395:" http://sonarqube:9000/api/v2/analysis/jres?os=linux&arch=aarch64'
                // Lancer l'analyse SonarQube
                sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=mod17-act1 -Dsonar.sources=. -Dsonar.login=${env.SONARQUBE_TOKEN} -X"
           
            }
        }
    }
}


        stage('Push to DockerHub') {
            steps {
                script {
                    echo "Attempting to push image to DockerHub"
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    docker.image("souf12/eoi-modulo17:latest").push()
                    sh 'docker logout'
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
