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
                sh 'docker build --no-cache -t gcr.io/prepro-273413/log4java:latest1 .'
            }
        }

        stage('Security Scan (If any doubt contact dstsol_soc_cloudmss@telefonica.com)') {
            steps {
                //Scan the image
                echo 'scan'
                echo 'If you have any doubt please contact to dstsol_soc_cloudmss@telefonica.com'
                prismaCloudScanImage ca: '',
                cert: '',
                dockerAddress: 'unix:///var/run/docker.sock',
                image: 'gcr.io/prepro-273413/log4java*',
                key: '',
                logLevel: 'info',
                podmanPath: '',
                project: '',
                resultsFile: 'prisma-cloud-scan-results.json',
                ignoreImageBuildTime:true
            }
        }

         stage('push gcr') {
            steps {
               
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS')]){
                    sh '''
                    sudo gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                    '''
                    sh '''
                    sudo gcloud auth configure-docker
                    '''
                    sh '''
                    sudo docker push gcr.io/prepro-273413/log4java:latest1
                    '''
                }                           
            }
        }
        stage('GCP Cloud Run Deployment') {
            steps {
               
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS')]){
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
            // Remove images
            //sh 'docker image rm masprieto/app-training:latest'
            sh 'docker image rm gcr.io/prepro-273413/log4java:latest'
            // docker logout
            sh 'docker logout'
            // The post section lets you run the publish step regardless of the scan results
            prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
        }
    }
}
