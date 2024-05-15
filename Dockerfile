FROM python:3.9
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
# 환경 변수 설정
ENV INPUT_QUERY="강남역 스시 맛집"
ENV FILE_PREFIX="gangnam_gourmet_sushi"
ENV DESTINATION_FILE_NAME="gangnam_gourmet.parquet"
CMD ["python", "crawler.py"]

