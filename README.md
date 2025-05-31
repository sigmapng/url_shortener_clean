# URL Shortener System

A modern Java web application for shortening URLs built with Jakarta EE and PostgreSQL.

## Features

- 🔗 **URL Shortening**: Convert long URLs into short, shareable links
- 📊 **Click Tracking**: Monitor how many times each link is accessed
- ⚡ **Fast Redirects**: Instant redirection to original URLs
- 🎨 **Modern UI**: Clean, responsive Bootstrap-based interface
- 🔒 **Secure**: Safe URL validation and secure random code generation

## Technology Stack

- **Backend**: Java 24, Jakarta EE 10
- **Frontend**: JSP, Bootstrap 5, CSS3
- **Database**: PostgreSQL
- **ORM**: Hibernate 6.2
- **Application Server**: WildFly
- **Build Tool**: Maven

## Project Structure

```
src/
├── main/
│   ├── java/com/urlshortener/
│   │   ├── model/          # JPA entities
│   │   ├── service/        # Business logic
│   │   ├── servlet/        # Web controllers
│   │   └── util/           # Utility classes
│   ├── resources/
│   │   └── META-INF/       # JPA configuration
│   └── webapp/
│       ├── css/            # Stylesheets
│       ├── js/             # JavaScript files
│       └── WEB-INF/        # Web configuration
```

## Quick Start

1. **Prerequisites**:

   - Java 24
   - PostgreSQL database
   - WildFly application server
   - Maven (optional, for building)

2. **Database Setup**:

   ```sql
   CREATE DATABASE url_shortener;
   CREATE USER url_user WITH PASSWORD 'password';
   GRANT ALL PRIVILEGES ON DATABASE url_shortener TO url_user;
   ```

3. **Configure WildFly DataSource**:

   - Add PostgreSQL driver module
   - Configure datasource with JNDI name: `java:jboss/datasources/PostgreSQLDS`

4. **Deploy**:

   - Build the WAR file: `mvn clean package`
   - Deploy to WildFly: Copy `target/url-shortener.war` to `wildfly/standalone/deployments/`

5. **Access**:
   - Open browser to `http://localhost:8080/url-shortener`

## API Endpoints

- `GET /` - Main page with URL shortening form
- `POST /shorten` - Create a short URL
- `GET /r/{shortCode}` - Redirect to original URL

## Database Schema

```sql
CREATE TABLE url_mappings (
    id BIGSERIAL PRIMARY KEY,
    original_url VARCHAR(2048) NOT NULL,
    short_code VARCHAR(10) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL,
    click_count BIGINT NOT NULL DEFAULT 0
);
```

## Development Notes

- Short codes are 6 characters long using alphanumeric characters
- URLs are automatically prefixed with `https://` if no protocol is specified
- Duplicate URLs return the existing short code
- Click counts are tracked for analytics

## Author

Coursework project - 2025
