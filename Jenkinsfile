pipeline {
    //agent { dockerfile true }
     //args '--entrypoint=\'\''
    agent {
        dockerfile {
            //args '--entrypoint=\'\''
        }
    }
    stages {
        stage('Test') {
            steps {
                //sh 'java -version'
                echo "hello from the other side"
            }
        }
    }
}
pipeline {   
  agent {
    node {
      label 'master'
    }  
  }
  stages {
    stage('checkout') {
      steps {
        checkout scm
        sh 'docker pull hashicorp/terraform:light'
      }
    }
  }
    stages {
    stage('plan') {
	   steps {
			withCredentials([[
				$class: 'AmazonWebServicesCredentialsBinding',
				credentialsId: 'arpanCredentials',
				accessKeyVariable: 'AWS_ACCESS_KEY_ID',
				secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
			]]) {
					sh 'echo `date`'
					sh 'terraform init -var accessKey=${AWS_ACCESS_KEY_ID} -var secretKey=${AWS_SECRET_ACCESS_KEY}'	
					sh 'terraform plan -var accessKey=${AWS_ACCESS_KEY_ID} -var secretKey=${AWS_SECRET_ACCESS_KEY}'
				}
			
		}
	}
    }
    stage('approval') {
      options {
        timeout(time: 0.5, unit: 'MINUTES') 
      }
      steps {
        input 'approve the plan to proceed and apply'
      }
    }
  }
