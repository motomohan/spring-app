pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    agent {label 'docker'} 
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Update Docker UAT image') {
            when { branch "master" }
            steps {
                sh '''
					docker login -u "motomohan" -p "Docker@1986!Jan2"
                    docker build --no-cache -t appimage .
                    docker tag appimage:latest motomohan/appimage:latest
                    docker push motomohan/appimage:latest
					docker rmi appimage:latest
                	'''
            }
        }
        stage('Update UAT container') {
            when { branch "master" }
            steps {
                sh '''
					docker login -u "motomohan" -p "Docker@1986!Jan2"
                    docker pull motomohan/appimage:latest
                    docker stop appimage
                    docker rm appimage
                    docker run -p 8000:9090 --name appimage -t -d motomohan/appimage
                    docker rmi -f $(docker images -q --filter dangling=true)
                '''
            }
        }
        stage('Release Docker image') {
            when { buildingTag() }
            steps {
                sh '''
					docker login -u "motomohan" -p "Docker@1986!Jan2"
                    docker build --no-cache -t appimage .
                    docker tag appimage:latest motomohan/appimage:${TAG_NAME}
                    docker push motomohan/person:${TAG_NAME}
					docker rmi $(docker images -f “dangling=true” -q)
               '''
            }
        }
    }
}
