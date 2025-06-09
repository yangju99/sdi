pipeline {
    agent {
        docker {
            image 'python:3.10'  // 원하는 Python 이미지
            // args '-v $PWD:/app -w /app'  // 현재 디렉토리를 컨테이너에 마운트
        }
    }

    stages {

        stage('CI') {
            steps {
                // decomposition.py 실행
                sh 'python CI/decomposition.py requirements.txt'

                // 결과 yaml 파일 아티팩트로 저장
                // archiveArtifacts artifacts: 'composition_plan.yaml'
            }
        }

        stage('CV') {
            steps {
                // navigate 서비스 시뮬레이션 테스트 수행
                sh 'python CV/launch_gaz_sim.py composition_plan.yml'

                // 결과 JSON 파일 아카이브
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
