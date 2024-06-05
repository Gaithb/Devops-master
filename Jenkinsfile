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
                // You can use Maven's deploy plugin to deploy artifacts to Nexus
                sh 'mvn deploy:deploy-file -Durl=http://192.168.2.164:8081/repository/maven-releases/ -DrepositoryId=nexus-releases -Dfile=path/to/your/artifact.jar -DgroupId=your.groupId -DartifactId=your-artifactId -Dversion=1.0.0 -Dpackaging=jar'
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
