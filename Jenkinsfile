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
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /mnt/myApp app composer install --ignore-platform-reqs'

                    // Generate Laravel application key
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /mnt/myApp app php artisan key:generate'

                    // Install PHPUnit and its dependencies
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /mnt/myApp app composer require --dev --with-all-dependencies phpunit/phpunit:^9.5'

                    // Run PHPUnit
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /mnt/myApp app ./vendor/bin/phpunit --log-junit=phpunit.xml'

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
