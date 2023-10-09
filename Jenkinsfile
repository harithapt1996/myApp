pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install dependencies
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app composer install --ignore-platform-reqs'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run PHPUnit tests
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app php artisan --env=testing test --log-junit=phpunit.xml'
                }
            }
        }

        stage('Deploy') {
            steps {
                // Your deployment steps go here
            }
        }
    }
}
