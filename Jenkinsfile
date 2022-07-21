pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred-masp')
    }      

    stages {
        stage('Git Clone') {
            steps {
                echo 'Clone'
                // remove clone, not necessary
                //sh 'git clone https://github.com/masanchezp/app-training-cloudmss.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Build'
                sh 'docker build --no-cache -t masprieto/app-training .'
            }
        }

        /*stage('Security Scan (If any doubt contact dstsol_soc_cloudmss@telefonica.com)') {
            steps {
                //Scan the image
                echo 'scan'
                echo 'If you have any doubt please contact to dstsol_soc_cloudmss@telefonica.com'
                prismaCloudScanImage ca: '',
                cert: '',
                dockerAddress: 'unix:///var/run/docker.sock',
                image: 'masprieto/app-training*',
                key: '',
                logLevel: 'info',
                podmanPath: '',
                project: '',
                resultsFile: 'prisma-cloud-scan-results.json',
                ignoreImageBuildTime:true
            }
        }*/

        /*stage('Login Dockerhub') {

			steps {
                echo 'Login Dockerhub'
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push Dockerhub') {

			steps {
                echo 'Push Dockerhub'
				sh 'docker push masprieto/app-training:latest'
			}
		}*/
        
        /*stage('AWS deployment') {

			steps {
                echo 'AWS Deployment'

                withAWS(credentials: 'AWS-jenkins-credentials', region: 'us-west-2') {
                //sh 'sudo python3 -m awscli s3 ls'
                sh 'sudo aws elasticbeanstalk update-environment --application-name "getting-started-app" --environment-name "Gettingstartedapp-env" --version-label=1'
                }
                //sh 'aws s3 ls'
                //sh 'docker run -d --rm -it -p 80:80 masprieto/app-training'
			}
		}*/
         stage('gcloud') {
            steps {
               
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS')]){
                    sh '''
                        sudo gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                    '''
                    sh '''
                    sudo gcloud auth configure-docker
                    '''
                    sh '''
                    sudo docker tag masprieto/app-training gcr.io/prepro-273413/log4java:latest
                    sudo docker push gcr.io/prepro-273413/log4java:latest
                    '''
                    sh '''
                    sudo gcloud run services replace service.yaml --platform='managed' --region='europe-southwest1'
                    '''
                    sh '''
                    sudo gcloud run services add-iam-policy-binding log4javasample --region='europe-southwest1' --member='allUsers' --role='roles/run.invoker'
                    ''' 
                }                           
            }
        }
    }
     post {
        always {
            echo 'Docker logout and more'
            // Remove image
            sh 'docker image rm masprieto/app-training:latest'
            // docker logout
            sh 'docker logout'
            // The post section lets you run the publish step regardless of the scan results
            prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
        }
    }
}
