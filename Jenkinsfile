pipeline {

    agent any

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Verify Files') {
            steps {
                sh 'pwd'
                sh 'ls -l'
            }
        }

        stage('Make Script Executable') {
            steps {
                sh 'chmod +x sqoop_import.sh'
            }
        }

        stage('Run Sqoop Import') {
            steps {
                sh './sqoop_import.sh'
            }
        }

        stage('Verify HDFS') {
            steps {
                sh 'hdfs dfs -ls /tmp/tfl_project_hadoop'
            }
        }

    }

    post {

        success {
            echo 'Pipeline executed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }

    }

}
