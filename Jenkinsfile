pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'ros_gui'
        WORK_DIR = '/root/sdi'
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
                echo 'Copying repo into existing docker container...'
                // sdi 디렉토리 전체 복사
                sh 'docker cp ./ ${CONTAINER_NAME}:${WORK_DIR}'

                echo 'Running Gazebo simulation inside container...'
                // 컨테이너에서 launch_gaz_sim 실행
                sh """
                    docker exec ${CONTAINER_NAME} bash -c "cd ${WORK_DIR} && python3 CV/launch_gaz_sim.py composition_plan.yml"
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
