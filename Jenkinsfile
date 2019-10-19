pipeline {
  environment {
    registry = "motomohan/appimage"
    registryCredential = 'docker'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/motomohan/spring-app.git'
      }
    }
    stage('Build Maven Image') {
        docker.build("maven-build") 
    }
    stage('Run Maven Container') {
        sh "docker run --rm --name maven-build-container maven-build"
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