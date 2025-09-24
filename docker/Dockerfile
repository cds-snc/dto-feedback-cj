FROM maven:3.8.6-openjdk-8-slim
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y wget ca-certificates
RUN mkdir -p /app
COPY target/pagefeedback-cj-1.0.0-SNAPSHOT.jar /app/app.jar

# Download AWS DocumentDB Certificate Authority (CA) certificate
RUN wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -O /tmp/global-bundle.pem

# Add DocumentDB certificate to the default Java truststore (cacerts)
RUN keytool -importcert -trustcacerts -file /tmp/global-bundle.pem -alias aws-documentdb -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt

# Clean up the temporary certificate file
RUN rm /tmp/global-bundle.pem

ENV JAVA_OPTS="-Xmx2g"
WORKDIR /app
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]
