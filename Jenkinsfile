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

                    // Run Laravel test command with explicit PHPUnit configuration
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app php artisan --env=testing config:cache'
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app php artisan --env=testing test --configuration /var/www/html/phpunit.xml --log-junit=phpunit.xml'
                    
                    // Print contents of the test directory for debugging
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app ls -la tests'

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
