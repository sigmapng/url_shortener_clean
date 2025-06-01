#!/bin/bash

# PostgreSQL WildFly Configuration Script
# This script configures PostgreSQL datasource in WildFly

echo "Configuring PostgreSQL datasource in WildFly..."

# Set WildFly directory
WILDFLY_HOME="/mnt/c/Users/riabk/Documents/wildfly-26.1.3.Final"

# Check if WildFly is running
if ! pgrep -f "standalone.sh" > /dev/null; then
    echo "Error: WildFly is not running. Please start WildFly first with: $WILDFLY_HOME/bin/standalone.sh"
    exit 1
fi

# Add PostgreSQL module
echo "Adding PostgreSQL module..."
$WILDFLY_HOME/bin/jboss-cli.sh --connect --command="module add --name=org.postgresql --resources=/mnt/c/Users/riabk/Documents/url-shortener-clean/postgresql-42.6.0.jar --dependencies=javax.api,javax.transaction.api"

# Add PostgreSQL driver
echo "Adding PostgreSQL driver..."
$WILDFLY_HOME/bin/jboss-cli.sh --connect --command="/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-class-name=org.postgresql.Driver)"

# Add PostgreSQL datasource
echo "Adding PostgreSQL datasource..."
$WILDFLY_HOME/bin/jboss-cli.sh --connect --command="data-source add --jndi-name=java:jboss/datasources/PostgreSQLDS --name=PostgreSQLDS --connection-url=jdbc:postgresql://localhost:5432/url_shortener --driver-name=postgresql --user-name=url_app --password=urlpass123 --enabled=true"

# Test the datasource connection
echo "Testing datasource connection..."
$WILDFLY_HOME/bin/jboss-cli.sh --connect --command="/subsystem=datasources/data-source=PostgreSQLDS:test-connection-in-pool"

echo "PostgreSQL datasource configuration completed!"
echo "You can now deploy your application."
