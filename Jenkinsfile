pipeline {
    agent any

    tools {
        maven 'M2_HOME'
    }

    stages {
        stage('GIT ') {
            steps {
                git branch: 'Gaith-b',
                    url: 'https://github.com/Gaithb/Devops-master.git'
            }
        }    
        stage('CLEAN') {
            steps {
                sh 'mvn clean'
            }
        }
        
        stage('Maven install') {
            steps {
                sh 'mvn install'
            }
        }
     stage('MVN TEST') {
         steps {
              sh 'mvn test'
           }
        }
        stage('MAVEN SONARQUBE') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar'
            }
        }
    }
         stage("Maven Build") {
            steps {
                script {
                    sh "mvn package -DskipTests=true"
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
