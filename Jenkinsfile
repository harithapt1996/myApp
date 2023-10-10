pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build("laravel")
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            script {
                // Clean up (stop and remove containers)
                sh 'docker-compose down'
            }
        }
    }
}
