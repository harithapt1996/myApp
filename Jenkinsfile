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

                    // Copy phpunit.xml to the Docker container
                    sh 'docker cp /mnt/myApp/phpunit.xml fe9bb53d56f5:/var/www/html/phpunit.xml'

                    // Run PHPUnit
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app vendor/bin/phpunit -c /var/www/html/phpunit.xml'

                    // Modify the PHPUnit XML file to remove invalid attributes
                    sh "sed -i 's/tests=\"[0-9]*\"//g' /mnt/myApp/phpunit.xml"
                    sh "sed -i 's/assertions=\"[0-9]*\"//g' /mnt/myApp/phpunit.xml"
                    sh "sed -i 's/errors=\"[0-9]*\"//g' /mnt/myApp/phpunit.xml"
                    sh "sed -i 's/failures=\"[0-9]*\"//g' /mnt/myApp/phpunit.xml"
                    sh "sed -i 's/skipped=\"[0-9]*\"//g' /mnt/myApp/phpunit.xml"
                    sh "sed -i 's/time=\"[0-9]*.[0-9]*\"//g' /mnt/myApp/phpunit.xml"

                    junit '/mnt/myApp/phpunit.xml'
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
