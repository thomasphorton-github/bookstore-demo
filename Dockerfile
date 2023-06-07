FROM openjdk:14-jdk-alpine

RUN mkdir /usr/local/bookstore
COPY . /usr/local/bookstore
WORKDIR /usr/local/bookstore
CMD ["sh","target/bin/webapp"]
