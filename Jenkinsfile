pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    sh(script: 'docker-compose build', returnStatus: true)
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh(script: 'docker-compose run app php artisan test', returnStatus: true)
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
