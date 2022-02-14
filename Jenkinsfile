pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                echo 'Clone'
                //sh 'git clone https://github.com/masanchezp/app-training-cloudmss.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Build'
                sh 'docker build --no-cache -t masprieto/app-training .'
            }
        }
    }
}
