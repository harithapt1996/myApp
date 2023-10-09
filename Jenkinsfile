pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'docker-compose run -w /mnt/myApp app ls -la'
                    sh 'docker-compose run -w /mnt/myApp app php artisan --version'
                    sh 'docker-compose run -w /mnt/myApp app cat .env'
                    sh 'docker-compose run -w /mnt/myApp app php artisan --env=testing config:cache'
                    sh 'docker-compose run -w /mnt/myApp app php artisan --env=testing test --log-junit=phpunit.xml'
                    junit 'phpunit.xml'
                }
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
