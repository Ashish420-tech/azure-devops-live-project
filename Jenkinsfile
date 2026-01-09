pipeline {
    agent any

    environment {
        IMAGE_NAME = "ashishmondal420/html-nginx"
        CONTAINER_NAME = "html-nginx-container"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'dev',
                    url: 'https://github.com/<your-username>/<your-repo>.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                cd app
                docker build -t $IMAGE_NAME:$BUILD_NUMBER .
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker run -d \
                -p 8082:80 \
                --name $CONTAINER_NAME \
                $IMAGE_NAME:$BUILD_NUMBER
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline executed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
