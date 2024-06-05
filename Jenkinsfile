pipeline {
    agent any

    tools {
        maven 'M2_HOME'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'Gaith-b',
                url: 'https://github.com/Gaithb/Devops-master.git'
            }
        }    

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn install'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar'
            }
        }
        
        stage('Package') {
            steps {
                script {
                    sh "mvn package -DskipTests=true"
                }
            }
        }
        
        stage('Deploy to Nexus') {
            steps {
                script {
                    sh "mvn deploy"
                }
            }
        }
        
        stage('Build Maven Spring') {
            steps {
                sh 'mvn clean install'
            }
        }
                         

        stage("Maven Build") {
            steps {
                script {
                    sh "mvn package -DskipTests=true"
                }
            }
        }
			

        stage('Docker push') {
            steps {
                sh 'echo "Docker is pushing ...."'
                sh 'docker push $DOCKERHUB_CREDENTIALS_USR/devopsimage:latest'
            }  
        }
        
        stage('docker compose') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
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
