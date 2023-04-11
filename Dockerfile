FROM registry.access.redhat.com/ubi8/openjdk-17:1.13 AS builder
WORKDIR /work
COPY . .
USER 0
RUN mvn clean package -DskipTests -DskipDocsGen

FROM registry.access.redhat.com/ubi8/openjdk-17-runtime:1.13
USER 185
WORKDIR /work/

COPY --from=builder /work/target/hacbs-test.jar /deployments

EXPOSE 8081

ENV AB_JOLOKIA_OFF=""
ENV JAVA_APP_JAR="/deployments/hacbs-test.jar"
