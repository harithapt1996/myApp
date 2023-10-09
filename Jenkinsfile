pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker-compose build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'docker-compose run app php artisan test'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy your application as needed
                    // This could involve pushing to a registry, deploying to a server, etc.
                }
            }
        }
    }
}

