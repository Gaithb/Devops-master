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
                nexusArtifactUploader artifacts: [[
                    artifactId: 'achat', 
                    classifier: '', 
                    file: 'achat/target/achat.war'
                ]], 
                credentialsId: '2bbeb356-05a7-47dd-9332-f1f073219cf0', 
                groupId: 'achat', 
                nexusUrl: 'http://192.168.2.164:8081', 
                nexusVersion: 'nexus2', 
                protocol: 'http', 
                repository: 'maven-snapshots', 
                version: '1.4-SNAPSHOT'
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
