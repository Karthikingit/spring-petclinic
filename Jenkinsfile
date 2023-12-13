pipeline {
    agent none
    stages {
        stage ('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Karthikingit/spring-petclinic.git'
            }
        }
        stage ('SonarQube Analysis') {
            agent {
                docker {
                    image 'maven:3.9.3-eclipse-temurin-11'
                    args '-v $PWD:/workspace'
                }
            }
            steps {
                withSonarQubeEnv(credentialsId: 'amx-sonarqube') {
                    sh "mvn clean verify sonar:sonar -Dsonar.projectKey=AMX -Dsonar.projectName='AMX'"
                }
            }
        }
        stage ('Build') {
            agent {
                docker {
                    image 'maven:3.9.3-eclipse-temurin-11'
                    args '-v $PWD:/workspace -v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                sh "mvn package -Dmaven.test.skip=true"
            }
        }
    }
}
