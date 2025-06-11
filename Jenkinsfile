pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'ros'
        WORK_DIR = '/root/sdi'
        SSH_PORT = '2222'
        SSH_HOST = 'localhost'
        SSH_USER = 'root'
    }

    stages {
        stage('CI') {
            steps {
                echo 'Running decomposition locally...'
                sh 'python CI/decomposition.py requirements.txt'
                // archiveArtifacts artifacts: 'composition_plan.yaml'
            }
        }

        stage('CV') {
            steps {
                echo 'Copying repo into container over SSH...'
                // scp로 디렉토리 복사
                sh """
                    ssh -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST} 'rm -rf ${WORK_DIR}'
                    scp -P ${SSH_PORT} -r . ${SSH_USER}@${SSH_HOST}:${WORK_DIR}
                """

                echo 'Running simulation inside container via SSH...'
                // SSH로 명령 실행
                sh """
                    ssh -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST} \\
                    'cd ${WORK_DIR} && python3 CV/launch_gaz_sim.py composition_plan.yml'
                """
                // archiveArtifacts artifacts: 'cv_results.json'
            }
        }
    }

    post {
        failure {
            echo 'Build failed!'
        }
        success {
            echo 'Build succeeded!'
        }
    }
}
