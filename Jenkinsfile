// pipeline {
//     agent none
//     stages {
//         stage ('SonarQube Analysis') {
//             agent {
//                 docker {
//                     image 'maven:3.9.3-eclipse-temurin-11'
//                     args '-v $PWD:/workspace'
//                 }
//             }
//             steps {
//                 withSonarQubeEnv(credentialsId: 'amx-sonarqube') {
//                     sh "mvn clean verify sonar:sonar -Dsonar.projectKey=AMX -Dsonar.projectName='AMX'"
//                 }
//             }
//         }
//         stage ('Build') {
//             agent {
//                 dockerContainer {
//                     image 'maven:3.9.3-eclipse-temurin-11'
//                     args '-v $PWD:/workspace -v $HOME/.m2:/root/.m2'
//                 }
//             }
//             steps {
//                 sh "mvn package -Dmaven.test.skip=true"
//             }
//         }
//     }
// }
pipeline {
        agent any
    tools {
        jfrog 'jfrog-cli'
        maven 'maven'
    }
    // environment {
    //     SCANNER_HOME = tool 'amx-sonarqube'
    // }
    stages {
        stage('Checkout') {
            steps {
                checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/spring-projects/spring-petclinic.git']])
            }
        }
        // stage ('SonarQube Analysis') {
        //     agent {
        //         docker {
        //             image 'maven:3.9.1-eclipse-temurin-17'
        //             args '-v $PWD:/workspace'
        //         }
        //     }
        //     steps{
        //         withSonarQubeEnv('amx-sonarqube') {
        //             sh "mvn clean verify sonar:sonar -Dsonar.projectKey=AMX -Dsonar.projectName='AMX'"
        //     }
        //     }
        // }
        stage('Exec Maven') {
            // agent any
            steps {
                    // Configure Maven project's repositories
                    jf 'rt ping'
                    jf 'mvn-config --repo-resolve-releases libs-release --repo-resolve-snapshots libs-snapshots --repo-deploy-releases libs-release-local --repo-deploy-snapshots libs-snapshot-local'

                    // Install and publish project
                    jf 'mvn clean package -DskipTests' 
                }
            }
        stage('Publish build info') {
            steps {
                jf 'rt build-publish'
            }
        }
    }
}

        // stage ('Build') {
        //     agent {
        //         docker {
        //             image 'usernamedoc/petclinic:mvn'
        //             args '-v $PWD:/workspace'
        //             registryCredentialsId 'dockerhub'
        //         }
        //     }
        //     steps{
        //         sh "mvn package -Dmaven.test.skip=true"
        //     }
        // }
        // stage ('Build') {
        //     agent node1 {
        //         sh 'docker run -it --name mvn2_container -v /home/karthik/spring-petclinic:/app/data1 -v ~/.m2:/app/data2 -w /app/data1 maven:3.8.1-openjdk-17 mvn  package -Dmaven.test.skip=true'
        //     }
        // }


