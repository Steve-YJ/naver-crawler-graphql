# Naver Crawler for Gangnam Restaurants
이 프로젝트는 "강남역 맛집"에 대한 데이터를 수집하는 Python 기반 도커 애플리케이션입니다. GraphQL을 사용하여 데이터를 수집하고, Google Cloud Storage에 저장합니다.

## 프로젝트 구조
```text
.
├── Dockerfile # 도커 이미지를 빌드하기 위한 파일
├── README.md # 프로젝트 설명 파일
├── crawler.py # 웹 크롤링 실행 스크립트
├── key.json # Google Cloud 인증을 위한 키 파일 (버전 관리에서 제외됨)
└── requirements.txt # 필요한 파이썬 패키지 목록
```

## Dockerfile
Dockerfile은 Python 3.9 이미지를 기반으로, 필요한 Python 패키지를 설치하고 환경 변수를 설정합니다. 자세한 내용은 Dockerfile을 참조해주세요.

## 사용 방법
1. **환경 설정**: Docker Application을 설치합니다
    ```bash
    # 시스템의 패키지 목록을 최신 상태로 업데이트합니다.
    sudo apt-get update
    
    # Docker 설치를 위해 필요한 패키지(ca-certificates, curl)를 설치합니다.
    sudo apt-get install ca-certificates curl
    # APT 키링을 저장할 디렉토리를 생성합니다.
    sudo install -m 0755 -d /etc/apt/keyrings
    # Docker의 공식 GPG 키를 다운로드하여 /etc/apt/keyrings/docker.asc에 저장합니다.
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    # 다운로드된 GPG 키 파일에 모든 사용자가 읽을 수 있는 권한을 부여합니다.
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # Docker의 APT 리포지토리를 시스템의 APT 소스 리스트에 추가합니다.
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # 새로운 Docker 소스를 추가한 후 시스템의 패키지 목록을 다시 업데이트합니다.
    sudo apt-get update
    # Docker가 성공적으로 설치되었는지 확인하기 위해 hello-world 이미지를 실행합니다.
    sudo docker run hello-world
    ```
2. **Docker 이미지 빌드**:
   ```bash
   sudo docker build --no-cache -t "crawler-app" . # 변경사항이 발생할 경우 사용
   ```
4. **Docker 컨테이너 실행**:
   ```bash
   sudo docker run -d -e INPUT_QUERY="강남역 스시 맛집" -e FILE_PREFIX="test/docker/gangnam_gourmet" -e DESTINATION_FILE_NAME="gangnam_gourmet.parquet" crawler-app
   ```

## 설정
* INPUT_QUERY: 크롤링할 검색어입니다. 예: "강남역 스시 맛집"
* FILE_PREFIX: 파일 저장 시 사용될 접두어입니다.
* DESTINATION_FILE_NAME: 저장될 파일의 이름입니다.


## 안전한 인증
key.json은 Google Cloud 인증에 사용되며, 보안을 위해 버전 관리에서 제외되어야 합니다. .gitignore 파일에 해당 파일을 포함시켜 보안을 유지하세요.

## 이슈
* [ ] 다른 환경에서 실행시 crawler.py 스크립트 내 bucker_name을 변경해줘야함. (* 기존 버킷에 권한이 없을 경우 데이터 삽입 불가)
