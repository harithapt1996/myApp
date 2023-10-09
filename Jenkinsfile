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
                    // Install specific versions of PHPUnit, phpunit/php-code-coverage, and dependencies
                    sh 'docker-compose -f /mnt/myApp/docker-compose.yml --env-file /mnt/myApp/.env run -w /var/www/html app composer require --dev phpunit/phpunit:9.5.10 phpunit/php-code-coverage:9.2.10 phpunit/php-file-iterator:3.0.6 phpunit/php-invoker:3.1.1 phpunit/php-text-template:2.0.3 sebastian/code-unit-reverse-lookup:2.0.2 sebastian/complexity:2.0.2 sebastian/environment:5.1.5 phpunit/php-timer:5.0.3 --ignore-platform-reqs'
                }
            }
        }

        stage('Test') {
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
