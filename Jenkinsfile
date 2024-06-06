pipeline {
    agent any
    
    environment {
        MAIN_VERSION = "1.1"
        BUILD_VERSION = "${MAIN_VERSION}-b${env.BUILD_NUMBER}"
        DOCKER_CREDENTIALS = credentials('20f8a19d-ef23-4271-94fa-e490ba447dc1')
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
                    sh 'docker build -t Gaithb/achat:1.9 .'
                }
            }
        }


stage('Push Docker Image to DockerHub') {
                    steps {
                        script {
                            withCredentials([usernamePassword(credentialsId: '20f8a19d-ef23-4271-94fa-e490ba447dc1', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {

                            sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
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
