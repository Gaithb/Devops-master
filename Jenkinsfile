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

        stage('Junit|Mockito') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }       
        
        stage('Run Tests with JaCoCo') {
            steps {
                script {
                    // Run tests with JaCoCo coverage
                    sh 'mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent test'
                }
            }
        }

        // stage('Generate Report') {
        //     steps {
        //         script {
        //             // Generate JaCoCo report
        //             sh 'mvn org.jacoco:jacoco-maven-plugin:report'
        //         }
        //         // Archive JaCoCo report
        //         archiveArtifacts artifacts: 'target/site/jacoco/*', fingerprint: true
        //     }
        // }

        stage('SonarQube Analysis') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar'
            }
        }
        
        stage('Install') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Deploy to Nexus') {
            steps {
                echo 'Deploying to Nexus server'
                sh 'mvn deploy'
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

        stage('Docker Compose UP') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
                }
            }
        }
    }


    post {
        always {
            emailext (
                subject: "Pipeline Status: ${currentBuild.result}",
                body: '''<html>
                            <body>
                                <p>Build Status: ${currentBuild.result}</p>
                                <p>Build Number: ${currentBuild.number}</p>
                                <p>Check the <a href="${env.BUILD_URL}">console output</a>.</p>
                            </body>
                           </html>''',
                to: 'mohamedgaith.basly@esprit.tn',
                from: 'mohamedgaith.basly@esprit.tn',
                replyTo: 'mohamedgaith.basly@esprit.tn',
                mimeType: 'text/html'
            )
        }
    }
}
