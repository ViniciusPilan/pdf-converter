FROM python:3.11-slim

ADD . /home/api/
WORKDIR /home/api
ENV PYTHONUNBUFFERED=true
EXPOSE 80
RUN pip3 install -r requirements.txt

ENTRYPOINT [ "python3", "api.py" ]