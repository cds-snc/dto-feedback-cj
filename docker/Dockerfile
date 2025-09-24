FROM maven:3.8.6-openjdk-8-slim
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y wget ca-certificates
RUN mkdir -p /app
COPY target/pagefeedback-cj-1.0.0-SNAPSHOT.jar /app/app.jar

# Download AWS DocumentDB Certificate Authority (CA) certificate bundle
RUN wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -O /tmp/global-bundle.pem

# Split the certificate bundle and import each certificate individually
RUN apt-get install -y openssl && \
    mkdir -p /tmp/certs && \
    cd /tmp/certs && \
    csplit -f cert- /tmp/global-bundle.pem '/-----BEGIN CERTIFICATE-----/' '{*}' && \
    for cert in cert-*; do \
    if [ -s "$cert" ]; then \
    keytool -importcert -trustcacerts -file "$cert" -alias "aws-documentdb-$cert" -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt || true; \
    fi; \
    done && \
    rm -rf /tmp/certs /tmp/global-bundle.pem

ENV JAVA_OPTS="-Xmx2g"
WORKDIR /app
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]
