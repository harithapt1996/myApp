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
                    dir('/mnt/myApp') {
                        sh 'docker-compose up -d'
                    }
                }
            }
        }
        
        // Add a new stage for echo statement
        stage('Show Change') {
            steps {
                echo 'This is a change in the Jenkinsfile!'
            }
        }
    }

    post {
        always {
            script {
                // Clean up (stop and remove containers)
                dir('/mnt/myApp') {
                    sh 'docker-compose down'
                }
            }
        }
    }
}
