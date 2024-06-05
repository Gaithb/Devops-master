pipeline {
    agent any

    tools {
        maven 'M2_HOME'
    }

    stages {
        stage('Git') {
            steps {
                git branch: 'Gaith-b',
                    url: 'https://github.com/Gaithb/Devops-master.git'
            }
        }    

        stage('Maven clean and install') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('MAVEN SONARQUBE') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar'
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
