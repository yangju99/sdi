pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'ros'
        WORK_DIR = '/root/sdi'
        SSH_PORT = '2222'
        SSH_HOST = 'localhost'
        SSH_USER = 'root'
        SSH_PASSWORD = '1234'
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
                    sshpass -p "${SSH_PASSWORD}" ssh -o StrictHostKeyChecking=no -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST} 'rm -rf ${WORK_DIR}'
                    sshpass -p "${SSH_PASSWORD}" scp -o StrictHostKeyChecking=no -P ${SSH_PORT} -r . ${SSH_USER}@${SSH_HOST}:${WORK_DIR}
                """

                echo 'Running simulation inside container via SSH...'
                // SSH로 명령 실행
                sh """
                    sshpass -p "${SSH_PASSWORD}" ssh -o StrictHostKeyChecking=no -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST} \\
                    'cd ${WORK_DIR} && source /opt/ros/humble/setup.bash && source ~/turtlebot3_ws/install/setup.bash && python3 CV/launch_gaz_sim.py composition_plan.yml'
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
