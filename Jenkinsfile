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

                    // Generate Laravel application key
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app php artisan key:generate'

                    // Install PHPUnit and its dependencies
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app composer require --dev --with-all-dependencies phpunit/phpunit'

                    // Run PHPUnit and generate the XML report
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app vendor/bin/phpunit --log-junit=phpunit.xml'

                    // Check if PHPUnit XML file exists and publish JUnit results
                    if (fileExists('phpunit.xml')) {
                        junit 'phpunit.xml'
                    } else {
                        error 'PHPUnit XML file not found.'
                    }
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
