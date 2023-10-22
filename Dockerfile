FROM python:3.11-slim

COPY . /home/
WORKDIR /home

RUN mkdir /home/tmp \
    && pip3 install -r requirements.txt

ENV TMP_FILE_PATH="/home/tmp/pdf_file.pdf"
EXPOSE 80

CMD [ "uvicorn", "api:app", "--reload", "--host", "0.0.0.0", "--port", "80" ]
