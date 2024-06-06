pipeline {
    agent any
    
    environment {
        MAIN_VERSION = "1.9"
        BUILD_VERSION = "${MAIN_VERSION}-b${env.BUILD_NUMBER}"
        DOCKER_CREDENTIALS = credentials('5a994b69-2de9-4b5c-a541-1f9495092a2a')
    }

    tools {
        maven 'M2_HOME'
    }

    stages {
        stage('Checkout GIT') {
            steps {
                git branch: 'Gaith-b',
                url: 'https://github.com/Gaithb/Devops-master.git'
            }
        }

        stage('MVN Clean & Install') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test Junit & Mockito') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t Gaithb/achat:${BUILD_VERSION} .'
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: '5a994b69-2de9-4b5c-a541-1f9495092a2a', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "echo ${DOCKERHUB_PASSWORD} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin"
                        sh "docker push Gaithb/achat:${BUILD_VERSION}"
                    }
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                echo 'Deploying to Nexus server'
                sh 'mvn deploy'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
