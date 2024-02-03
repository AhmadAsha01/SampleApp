FROM python:3.8-slim

WORKDIR /app

COPY . /app

RUN apt-get -y update && apt-get -y install curl

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080
  
CMD [ "waitress-serve", "--listen=0.0.0.0:8080" , "main:app"]
