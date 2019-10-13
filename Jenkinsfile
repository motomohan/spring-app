node {

   stage('Clone Repository') {
        // Get some code from a GitHub repository
        git 'https://github.com/motomohan/spring-app.git'
    
   }
   stage('Build Maven Image') {
        docker.build("maven-build") 
   }
   
   stage('Run Maven Container') {
       withEnv([
	    "DOCKER_HOST=tcp://localhost:2375",
  		])
        //Run maven image
        {
   			 sh "docker run --rm --name maven-build-container maven-build"
		}
        
   }
   
   stage('Deploy Spring Boot Application') {
        
         //Remove maven-build-container if it exists
        sh " docker rm -f java-deploy-container"
       
        sh "docker run --name java-deploy-container --volumes-from maven-build-container -d -p 8080:8080 motomohan/appimage"
   }

}