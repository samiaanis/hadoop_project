pipeline {

```
agent any

environment {
    REMOTE_HOST = '13.41.167.97'
    REMOTE_USER = 'consultant'
    REMOTE_PASSWORD = 'WelcomeItc@2026'
    PROJECT_DIR = '/tmp/tfl_hadoop_project'
}

stages {

    stage('Checkout') {
        steps {
            checkout scm
        }
    }

    stage('Run Sqoop Import') {
        steps {
            sh '''
                sshpass -p "${REMOTE_PASSWORD}" ssh \
                -o StrictHostKeyChecking=no \
                -o UserKnownHostsFile=/dev/null \
                ${REMOTE_USER}@${REMOTE_HOST} \
                "cd ${PROJECT_DIR} && chmod +x sqoop_import.sh && ./sqoop_import.sh"
            '''
        }
    }

    stage('Verify HDFS') {
        steps {
            sh '''
                sshpass -p "${REMOTE_PASSWORD}" ssh \
                -o StrictHostKeyChecking=no \
                -o UserKnownHostsFile=/dev/null \
                ${REMOTE_USER}@${REMOTE_HOST} \
                "hdfs dfs -ls /tmp/tfl_project_hadoop"
            '''
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
```

}
