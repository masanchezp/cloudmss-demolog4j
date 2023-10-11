pipeline {
    agent any    

    stages {
        stage('Git Clone') {
            steps {
                echo 'Clone'
                
            }
        }
        stage('Build') {
            steps {
                echo 'Build'
                sh 'docker build --no-cache -t europe-southwest1-docker.pkg.dev/banded-coder-401610/cloudmss/log4java:latest .'
            }
        }

        stage('Security Scan (If any doubt contact dstsol_soc_cloudmss@telefonica.com)') {
            steps {
                //Scan the image
                echo 'scan'
                echo 'If you have any doubt please contact to dstsol_soc_cloudmss@telefonica.com'
                //prismaCloudScanImage ca: '',
                //cert: '',
                //dockerAddress: 'unix:///var/run/docker.sock',
                //image: 'europe-southwest1-docker.pkg.dev/banded-coder-401610/cloudmss/log4java*',
                //key: '',
                //logLevel: 'info',
                //podmanPath: '',
                //project: '',
                //resultsFile: 'prisma-cloud-scan-results.json',
                //ignoreImageBuildTime:true
            }
        }
         stage('push gcr') {
            steps {
               
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS')]){
                    sh '''
                    sudo gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                    '''
                    sh '''
                    sudo gcloud auth configure-docker europe-southwest1-docker.pkg.dev
                    '''
                    sh '''
                    sudo docker push europe-southwest1-docker.pkg.dev/banded-coder-401610/cloudmss/log4java:latest
                    '''
                }                           
            }
        }
        stage('GCP Cloud Run Deployment') {
            steps {
               
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS')]){
                     sh '''
                    sudo gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                    '''
                    sh '''
                    sudo gcloud run services replace service.yaml --platform='managed' --region='europe-southwest1'
                    '''
                    sh '''
                    sudo gcloud run services add-iam-policy-binding demolog4jcloudmss --region='europe-southwest1' --member='allUsers' --role='roles/run.invoker'
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
            sh 'docker image rm europe-southwest1-docker.pkg.dev/banded-coder-401610/cloudmss/log4java:latest'
            // docker logout
            sh 'docker logout'
            // The post section lets you run the publish step regardless of the scan results
            prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
        }
    }
}


