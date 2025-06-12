CI-CV-CD pipeline
=======================
requirement.txt 파일이 변경되면(git push), jenkins의 SCM polling을 통해 자동으로 CI-CV-CD pipeline 수행됨 


CI: jenkins-server에서 실행 
-------------------------
description: user requirement를 input으로 받아서 LLM을 통해 필요한 service(ros node)들 추출 

input: requirement.txt 

output: composition_plan.yaml 

decomposition.py: requirement.txt  -->  composition_plan.yaml


CV: ROS 설치된 docker container(ros server)에서 실행 
-----------------------------------------------------
description: CI 에서 얻어낸 ros node(service)들의 composition을 simulation 환경에서 integration testing

input: composition_plan.yaml

output: evaluation_result.json

launch_gz_sim: composition_plan.yaml을 기반으로 cv.sh 생성 

cv.sh: composition_plan.yaml파일에 명시된 service들에 해당하는 ros node를 launch 하는 스크립트 

test case.json: 선택된 ros node들의 조합(composition)을 integration testing 하기 위한 test case.  
  test input: voice of user 
  ex) "deliver this book to bob"  
  test output: ground truth of behavior of turtlebot 
  ex) pose of bob in the predefined map  

Note!! 
ros server에 모든 서비스들이 ros node형태로 미리 정의되어 있어야 함. 
그래야만 cv.sh에서 ros launch 명령어로 node들을 create할 수 있음 
ex) navigation node, speech-to-text node


CD: 터틀봇과 클라우드(PC) 로 구성된 kubernetes cluster에서 실행 
-----------------------------------------------------
description: ros node들을 각각 컨테이너화 시킨 후, 배포 전략에 따라 터틀봇과 클라우드에 적절히 배포 

Note!!
아래 2개의 네트워크를 어떻게 integrate할 것인가?
ROS node들끼리의 통신(publish, subscribe)
kubernetes 클러스터에서 파드들끼리의 통신 


