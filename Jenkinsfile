pipeline {
    agent any
    stages {
        stage('hello AWS') {
            steps {
                withAWS(credentials: 'awsCredentials', region: 'us-east-1') {
                    sh 'echo "hello KB">hello.txt'
                }
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
    stage('init') {
      steps {
        sh 'docker run -w /app -v /awsCredentials:/awsCredentials -v `pwd`:/app hashicorp/terraform:light init'
      }
    }
    stage('plan') {
      steps {
        sh 'docker run -w /app -v /awsCredentials:/awsCredentials -v `pwd`:/app hashicorp/terraform:light plan'
      }
    }
    stage('approval') {
      options {
        timeout(time: 1, unit: 'HOURS') 
      }
      steps {
        input 'approve the plan to proceed and apply'
      }
    }
    stage('apply') {
      steps {
        sh 'docker run -w /app -v /awsCredentials:/awsCredentials -v `pwd`:/app hashicorp/terraform:light apply -auto-approve'
        cleanWs()
      }
    }
  }
}
