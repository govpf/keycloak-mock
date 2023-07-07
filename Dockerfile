# Keycloak version
ARG KEYCLOAK_VERSION=15.1.0
FROM jboss/keycloak:${KEYCLOAK_VERSION}

# Copy script do dowload config, extension, and theme
RUN mkdir /tmp/local-realms # used to un-tar config
COPY ./entrypoint.sh entrypoint.sh
USER root
RUN chmod 775 entrypoint.sh
USER jboss
# Config, extension and theme versions
USER jboss
ENV KEYCLOAK_CONFIGURATIONS_VERSION=snapshot/keycloak-dicp-configuration-feature-docker-image.tar.gz
ENV KEYCLOAK_EXTENSIONS_VERSION=snapshot/keycloak-dicp-extensions-feature-generic-endpoint.jar
ENV KEYCLOAK_THEMES_VERSION=snapshot/keycloak-dicp-themes-develop.jar

# Configure keycloak
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin
ENV DB_VENDOR=h2
ENV KEYCLOAK_IMPORT=pathtojsonrealm.json,pathtoanotherjsonrealm.json
ENV KEYCLOAK_MIGRATION_STRATEGY=IGNORE_EXISTING

# Run
ENTRYPOINT ["./entrypoint.sh"]
