pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker-compose build'
            }
        }

        stage('Test') {
            steps {
                sh 'docker-compose run app php artisan test'
            }
        }

        stage('Deploy') {
            steps {
                // Deploy your application as needed
                // This could involve pushing to a registry, deploying to a server, etc.
            }
        }
    }
}
