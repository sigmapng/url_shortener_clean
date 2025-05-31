-- URL Shortener Database Setup Script
-- Run this script in PostgreSQL to set up the database

-- Create database
CREATE DATABASE url_shortener;

-- Create user
CREATE USER url_user WITH PASSWORD 'password123';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE url_shortener TO url_user;

-- Connect to the database and create table
\c url_shortener;

-- Create the url_mappings table
CREATE TABLE IF NOT EXISTS url_mappings (
    id BIGSERIAL PRIMARY KEY,
    original_url VARCHAR(2048) NOT NULL,
    short_code VARCHAR(10) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    click_count BIGINT NOT NULL DEFAULT 0
);

-- Grant table permissions to user
GRANT ALL PRIVILEGES ON TABLE url_mappings TO url_user;
GRANT USAGE, SELECT ON SEQUENCE url_mappings_id_seq TO url_user;

-- Insert sample data (optional)
INSERT INTO url_mappings (original_url, short_code, created_at, click_count) VALUES
('https://www.google.com', 'abc123', CURRENT_TIMESTAMP, 0),
('https://www.github.com', 'def456', CURRENT_TIMESTAMP, 5),
('https://stackoverflow.com', 'ghi789', CURRENT_TIMESTAMP, 12);

-- Display table structure
\d url_mappings;

-- Display sample data
SELECT * FROM url_mappings;
