#!/usr/bin/env bash
set -e

# Download keycloak configurations
KEYCLOAK_CONFIGURATIONS_URL="https://bin.gov.pf/artifactory/applications/pareo/keycloak/configurations/${KEYCLOAK_CONFIGURATIONS_VERSION}"
echo "DOWNLOADING ${KEYCLOAK_CONFIGURATIONS_URL}"
curl -u ${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -k ${KEYCLOAK_CONFIGURATIONS_URL} -o /tmp/keycloak-dicp-configurations.tar.gz
echo "DONE!"
echo ""

# Download keycloak extensions
KEYCLOAK_EXTENSIONS_URL="https://bin.gov.pf/artifactory/applications/pareo/keycloak/extensions/${KEYCLOAK_EXTENSIONS_VERSION}"
echo "DOWNLOADING ${KEYCLOAK_EXTENSIONS_URL}"
curl -u ${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -k ${KEYCLOAK_EXTENSIONS_URL} -o /opt/jboss/keycloak/standalone/deployments/keycloak-dicp-extensions.jar
echo "DONE!"
echo ""

# Download keycloak themes
KEYCLOAK_THEMES_URL="https://bin.gov.pf/artifactory/applications/pareo/keycloak/themes/${KEYCLOAK_THEMES_VERSION}"
echo "DOWNLOADING ${KEYCLOAK_THEMES_URL}"
curl -u ${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -k ${KEYCLOAK_THEMES_URL} -o /opt/jboss/keycloak/standalone/deployments/keycloak-dicp-themes.jar
echo "DONE!"
echo ""

# Extract keycloak configurations
echo "EXTRACTING /tmp/keycloak-dicp-configuration.tar.gz"
tar xvzf /tmp/keycloak-dicp-configurations.tar.gz -C /tmp
echo "DONE!"
echo ""

# run keycloak
/opt/jboss/tools/docker-entrypoint.sh
