pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker-compose -f /root/docker/myApp/docker-compose.yml build'
            }
        }

        stage('Test') {
            steps {
                sh 'docker-compose run app php artisan test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment steps here
            }
        }
    }
}
