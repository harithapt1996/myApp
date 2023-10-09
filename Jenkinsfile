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
                    // Ensure Composer dependencies are installed
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app composer install --ignore-platform-reqs'

                    // Run PHPUnit without Laravel's php artisan test
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app vendor/bin/phpunit --log-junit=phpunit.xml'

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
