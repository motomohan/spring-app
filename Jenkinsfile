pipeline {
  environment {
    registry = "motomohan/appimage"
    registryCredential = 'docker'
    dockerImage = ''
  }
  agent any
  tools { 
        maven 'Maven 3.3.9' 
        jdk 'jdk8' 
    }
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/motomohan/spring-app.git'
      }
    }
    stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

    stage ('Build') {
        steps {
            sh 'mvn -Dmaven.test.failure.ignore=true install' 
        }
            
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}