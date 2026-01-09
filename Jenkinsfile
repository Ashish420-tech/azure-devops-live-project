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
                    url: 'https://github.com/Ashish420-tech/azure-devops-live-project.git'
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
        echo "Stopping any container using port 8082..."
        docker ps -q --filter "publish=8082" | xargs -r docker rm -f
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
