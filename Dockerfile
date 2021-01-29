FROM maven:3-openjdk-8 as builder
COPY ./app /app
WORKDIR /app
RUN ls && mvn clean install -DskipTests=false
FROM tomcat
RUN ["rm", "-rf", "/usr/local/tomcat/webapps/ROOT"]
COPY --from=builder /app/build/libs/*.jar /usr/local/tomcat/webapps/ROOT.jar
CMD ["java","-jar","/usr/local/tomcat/webapps/ROOT.jar"]
