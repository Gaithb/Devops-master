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
                    def jarName = "achat-${BUILD_VERSION}.jar"
                    sh "cp target/achat-1.9.jar target/${jarName}"  // Ensure the JAR file has the correct name
                    sh "docker build -t docker.io/gaihdocker/achat:${BUILD_VERSION} ."
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: '5a994b69-2de9-4b5c-a541-1f9495092a2a', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "echo ${DOCKERHUB_PASSWORD} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin"
                        sh "docker push docker.io/gaihdocker/achat:${BUILD_VERSION}"
                    }
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
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
        stage('Prometheus Metrics Export') {
            steps {
                script {
                    // Collect and export metrics in Prometheus format
                    sh 'mvn clean install' // Example command to run the build

                    // Modify this line to include the Java command with the correct path to the Prometheus plugin JAR
                    sh 'java -javaagent:/var/lib/jenkins/plugins/prometheus.hpi=8080:/path/to/prometheus-metrics'
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
