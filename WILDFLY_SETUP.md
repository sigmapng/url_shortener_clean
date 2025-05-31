# WildFly Configuration Guide

## PostgreSQL Driver Setup

1. **Download PostgreSQL JDBC Driver**:

   - Download `postgresql-42.6.0.jar` from [Maven Central](https://repo1.maven.org/maven2/org/postgresql/postgresql/42.6.0/)

2. **Create Module Directory**:

   ```
   wildfly/modules/system/layers/base/org/postgresql/main/
   ```

3. **Copy Driver**:

   - Place `postgresql-42.6.0.jar` in the module directory

4. **Create module.xml**:
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <module xmlns="urn:jboss:module:1.9" name="org.postgresql">
       <resources>
           <resource-root path="postgresql-42.6.0.jar"/>
       </resources>
       <dependencies>
           <module name="javax.api"/>
           <module name="javax.transaction.api"/>
       </dependencies>
   </module>
   ```

## DataSource Configuration

### Option 1: CLI Commands

1. **Start WildFly**:

   ```
   wildfly/bin/standalone.bat
   ```

2. **Open CLI** (new terminal):

   ```
   wildfly/bin/jboss-cli.bat --connect
   ```

3. **Add Driver**:

   ```
   /subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-class-name=org.postgresql.Driver)
   ```

4. **Add DataSource**:

   ```
   data-source add --name=PostgreSQLDS --jndi-name=java:jboss/datasources/PostgreSQLDS --driver-name=postgresql --connection-url=jdbc:postgresql://localhost:5432/url_shortener --user-name=url_user --password=password123 --enabled=true
   ```

5. **Test Connection**:
   ```
   /subsystem=datasources/data-source=PostgreSQLDS:test-connection-in-pool
   ```

### Option 2: Manual XML Configuration

Edit `wildfly/standalone/configuration/standalone.xml`:

```xml
<subsystem xmlns="urn:jboss:domain:datasources:6.0">
    <datasources>
        <!-- Add this datasource -->
        <datasource jndi-name="java:jboss/datasources/PostgreSQLDS" pool-name="PostgreSQLDS" enabled="true" use-java-context="true">
            <connection-url>jdbc:postgresql://localhost:5432/url_shortener</connection-url>
            <driver>postgresql</driver>
            <security>
                <user-name>url_user</user-name>
                <password>password123</password>
            </security>
        </datasource>

        <drivers>
            <!-- Add this driver -->
            <driver name="postgresql" module="org.postgresql">
                <driver-class>org.postgresql.Driver</driver-class>
            </driver>
        </drivers>
    </datasources>
</subsystem>
```

## Deployment

1. **Build Project**:

   ```
   mvn clean package
   ```

2. **Deploy WAR**:

   - Copy `target/url-shortener.war` to `wildfly/standalone/deployments/`
   - Or use CLI: `deploy target/url-shortener.war`

3. **Access Application**:
   - URL: `http://localhost:8080/url-shortener`

## Troubleshooting

- **Check WildFly logs**: `wildfly/standalone/log/server.log`
- **Verify datasource**: Use WildFly Admin Console at `http://localhost:9990`
- **Test database connection**: Use PostgreSQL client or CLI commands above
