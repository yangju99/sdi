pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // SCM에서 코드 클론
                checkout scm
            }
        }

        stage('CI') {
            steps {
                // decomposition.py 실행
                sh 'python CI/decomposition.py requirements.txt'

                // 결과 yaml 파일 아티팩트로 저장
                // archiveArtifacts artifacts: 'composition_plan.yaml'
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
