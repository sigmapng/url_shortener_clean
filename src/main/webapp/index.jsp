<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>URL Shortener</title>
      <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
      <div class="container mt-5">
        <div class="row justify-content-center">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h1 class="card-title">URL Shortener</h1>
                <p class="text-muted mb-0">Transform long URLs into short, shareable links</p>
              </div>
              <div class="card-body p-4">

                <!-- Success Message -->
                <c:if test="${success}">
                  <div class="alert alert-success" role="alert">
                    <h6 class="mb-2">URL shortened successfully!</h6>
                    <p class="mb-2"><strong>Original:</strong> ${originalUrl}</p>
                    <p class="mb-3"><strong>Short URL:</strong>
                      <a href="${shortUrl}" target="_blank" class="text-decoration-none">${shortUrl}</a>
                    </p>
                    <button class="btn btn-outline-secondary btn-sm" onclick="copyToClipboard('${shortUrl}')">
                      📋 Copy Link
                    </button>
                  </div>
                </c:if>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                  <div class="alert alert-danger" role="alert">
                    <strong>Error:</strong> ${error}
                  </div>
                </c:if>

                <!-- URL Shortening Form -->
                <form action="shorten" method="post" class="mb-4">
                  <div class="mb-3">
                    <label for="url" class="form-label">Enter URL to shorten</label>
                    <input type="url" class="form-control" id="url" name="url"
                      placeholder="https://example.com/your-long-url" required>
                    <div class="form-text">
                      Enter any valid URL with or without http/https prefix
                    </div>
                  </div>
                  <button class="btn btn-primary" type="submit">
                    Shorten URL
                  </button>
                </form>

                <!-- Features Section -->
                <div class="row">
                  <div class="col-md-4">
                    <div class="feature-box">
                      <h6>Fast & Reliable</h6>
                      <small>Instant URL shortening with secure redirects</small>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="feature-box">
                      <h6>Click Tracking</h6>
                      <small>Monitor link performance and analytics</small>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="feature-box">
                      <h6>Simple & Clean</h6>
                      <small>Easy to use interface with no registration</small>
                    </div>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>
      <script>
        function copyToClipboard(text) {
          navigator.clipboard.writeText(text).then(function () {
            alert('Short URL copied to clipboard!');
          }, function () {
            alert('Failed to copy URL to clipboard');
          });
        }
      </script>
    </body>

    </html>