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

                    // Install PHPUnit 9.x and php-code-coverage 9.x
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app composer require --dev phpunit/phpunit:^9.5 phpunit/php-code-coverage:^9.2.29 phpunit/php-file-iterator:^3.0.3 --ignore-platform-reqs'

                    // Run PHPUnit
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app vendor/bin/phpunit --log-junit=phpunit.xml'

                    // Modify the PHPUnit XML file to remove invalid attributes
                    sh "sed -i 's/tests=\"[0-9]*\"//g' phpunit.xml"
                    sh "sed -i 's/assertions=\"[0-9]*\"//g' phpunit.xml"
                    sh "sed -i 's/errors=\"[0-9]*\"//g' phpunit.xml"
                    sh "sed -i 's/failures=\"[0-9]*\"//g' phpunit.xml"
                    sh "sed -i 's/skipped=\"[0-9]*\"//g' phpunit.xml"
                    sh "sed -i 's/time=\"[0-9]*.[0-9]*\"//g' phpunit.xml"

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
