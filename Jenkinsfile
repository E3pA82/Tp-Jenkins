pipeline {
    agent any

    tools {
        maven 'Maven-3'
    }

    environment {
        IMAGE = 'paatty/calculatrice:1.0.0'
    }

    stages {
        stage('Git Checkout') {
            steps {
                dir('mon-projet') {
                    git url: 'https://github.com/E3pA82/Tp-Jenkins.git', branch: 'master'
                }
            }
        }

        stage('Build') {
            steps {
                bat 'mvn -f mon-projet clean compile'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn -f mon-projet test'
            }
        }

        stage('Package') {
            steps {
                bat 'mvn -f mon-projet package'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker --version'
                bat 'docker build -t %IMAGE% mon-projet'
            }
        }

       stage('Push to Docker Hub') {
                steps {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                        bat 'docker push %IMAGE%'
                        bat 'docker logout'
                    }
                }
            }
    }
}