pipeline {
    agent any

    environment {
  //      MAIN_VERSION = "1.1"
    //    BUILD_VERSION = "${MAIN_VERSION}-b${env.BUILD_NUMBER}"
     //   DOCKER_CREDENTIALS = credentials('307f196d-c538-49e8-b350-bc5caa31b442')
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

      //  stage('Docker Build') {
        //    steps {
          //      script {
            //        docker.build("ssdrissi/timesheet-devops:${env.BUILD_VERSION}")
              //  }
           // }
        //}

       // stage('Push Docker Image to DockerHub') {
         //   steps {
           //     script {
             //       withCredentials([usernamePassword(credentialsId: '307f196d-c538-49e8-b350-bc5caa31b442', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
               //         sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                 //       sh "docker push ssdrissi/timesheet-devops:${env.BUILD_VERSION}"
                  //  }
               // }
        //    }
     //   }

       // stage('Docker compose (FrontEnd BackEnd MySql)') {
         //   steps {
           //     script {
             //       sh '/usr/local/bin/docker-compose up -d'
               // }
         //   }
      //  }

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
