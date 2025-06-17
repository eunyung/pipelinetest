pipeline {
    agent {
        label 'azcli' // az cli가 설치된 agent pod
    }

    environment {
        IMAGE_NAME = 'hellospring'
        ACR_NAME = 'acrrancher' // ACR 이름만, .azurecr.io 제외
        DOCKERFILE_PATH = '.'   // Dockerfile 위치 (예: ./ 또는 ./src 등)
        TENANT = '7b79809c-09b9-4baa-ab98-ef8d94c6923f'
        TAG = "0.1.${env.BUILD_NUMBER}"
    }

    stages {
        stage('Login to Azure') {
            steps {
                withCredentials([
                    usernamePassword(credentialsId: 'jenkins-sp', usernameVariable: 'AZURE_CLIENT_ID', passwordVariable: 'AZURE_CLIENT_SECRET')
                ]) {
                    sh '''
                        az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $TENANT --output none
                    '''
                }
            }
        }

        stage('Build and Push to ACR') {
            steps {
                sh '''
                    az acr build --registry $ACR_NAME --image $IMAGE_NAME:$TAG $DOCKERFILE_PATH
                '''
            }
        }
    }
}
