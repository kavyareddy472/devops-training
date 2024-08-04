pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    parameters{
        string(name:'Env',defaultValue:'Test',description:'env to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'VERSION',choices:['1.1','1.2','1.3'])
    }
    environment{
      BUILD_SERVER_IP='ec2-user@172.31.10.129'
      IMAGE_NAME='madlearn/devops'
    }

    stages {
        stage('Compile') {
            steps {
                script{
                    echo "Compiling the code ${params.Env}"
                    sh "mvn compile"
                }
                
            }

            
        }
        stage('UnitTest') { // running on slave1
            when{
                expression{
                    params.executeTests == true
                }
            }
            steps {
                script{
                    echo "RUNNING THE TC"
                    sh "mvn test"
                }
                }
            
            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }
            
        }
        stage('build container image') { // running on slave2 via ssh-agent
            steps {
              script {
                sshagent(['slave2']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                sh "scp -o StricthostkeyChecking=no server-config.sh ${BUILD_SERVER_IP}:/home/ec2-user"
                sh "ssh -o strictHostKeyChecking=no ${BUILD_SERVER_IP} bash 'server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                sh "ssh ${BUILD_SERVER_IP} sudo docker login -u ${username} -p ${password}"
                sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"

                }
              }
              }
            }
       }
    }
}
