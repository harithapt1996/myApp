pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    dir('/mnt/myApp') {
                        sh 'docker build -t your-laravel-app .'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    dir('/mnt/myApp') {
                        sh 'docker-compose down'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Additional cleanup or actions if needed
            }
        }
    }
}
