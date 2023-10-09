pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker-compose -f /docker/myApp/docker-compose.yml --env-file /root/docker/myApp/.env build'
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
