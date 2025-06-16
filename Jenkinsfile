pipeline {
	agent { label 'jenkins-jenkins-agent' }
	stages {
		stage("Docker") {
			agent { label 'jenkins-jenkins-agent' }
			environment{
				credential = "acracceeskey"
				registry = "acrrancher.azurecr.io"
				image = "hellospring"
				tag = "0.1.${env.BUILD_NUMBER}"
			}
			steps {
				script {
					withDockerRegistry(credentialsId: "$credential", url: "https://$registry") {
						def img = docker.build("$registry/$image:$tag", "--network host .")
						img.push()
					}
				 	sh "docker rmi $registry/$image:$tag" // docker image 제거
				}
			}
		}

		// stage('K8S Manifest Update') {
		//     environment{
        //         tag = "0.1.${env.BUILD_NUMBER}"
        //     }
        //     steps {
        //         git branch: "main",
        //             credentialsId: "{gitlab accesstoken 관련 credential ID}",
        //             url: "{manifest 파일 저장된 gitlab url}"

        //         withCredentials([usernamePassword(credentialsId: '{gitlab accesstoken 관련 credential ID}', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
        //             sh '''
        //             git config --local credential.helper "!f() { echo username=$GIT_USERNAME; echo password=$GIT_PASSWORD; }; f"
        //             sed -i "s/{image명}:.*\$/{image명}:$tag/g" {image명}/${BUILD_ENV}/deployment.yaml
        //             git add {image명}/${BUILD_ENV}/deployment.yaml
        //             git commit -m "[UPDATE] {image명} $tag image versioning"
        //             git push origin main
        //             '''
        //         }
        //     }
        //     post {
        //             failure {
        //               echo 'K8S Manifest Update failure !'
        //             }
        //             success {
        //               echo 'K8S Manifest Update success !'
        //             }
        //     }
        // }
	}
}
