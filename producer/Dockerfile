FROM python:3.10-alpine
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY producer.py .
RUN pip3 install boto3
ENTRYPOINT python3 producer.py
