<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>URL Shortener</title>
      <link href="css/style.css" rel="stylesheet">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
      <div class="container mt-5">
        <div class="row justify-content-center">
          <div class="col-md-8">
            <div class="card shadow">
              <div class="card-header bg-primary text-white">
                <h1 class="card-title mb-0">🔗 URL Shortener</h1>
              </div>
              <div class="card-body">

                <!-- Success Message -->
                <c:if test="${success}">
                  <div class="alert alert-success" role="alert">
                    <h5 class="alert-heading">✅ URL Shortened Successfully!</h5>
                    <p><strong>Original URL:</strong> ${originalUrl}</p>
                    <p><strong>Short URL:</strong>
                      <a href="${shortUrl}" target="_blank" class="text-decoration-none">${shortUrl}</a>
                    </p>
                    <button class="btn btn-outline-success btn-sm" onclick="copyToClipboard('${shortUrl}')">
                      📋 Copy Link
                    </button>
                  </div>
                </c:if>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                  <div class="alert alert-danger" role="alert">
                    <strong>❌ Error:</strong> ${error}
                  </div>
                </c:if>

                <!-- URL Shortening Form -->
                <form action="shorten" method="post" class="mb-4">
                  <div class="mb-3">
                    <label for="url" class="form-label">Enter URL to shorten:</label>
                    <div class="input-group">
                      <input type="url" class="form-control form-control-lg" id="url" name="url"
                        placeholder="https://example.com/very-long-url" required>
                      <button class="btn btn-primary btn-lg" type="submit">
                        ⚡ Shorten URL
                      </button>
                    </div>
                    <div class="form-text">
                      Enter any valid URL (with or without http/https prefix)
                    </div>
                  </div>
                </form>

                <!-- Features Section -->
                <div class="row mt-4">
                  <div class="col-md-4 text-center mb-3">
                    <div class="feature-icon">⚡</div>
                    <h6>Fast & Reliable</h6>
                    <small class="text-muted">Instant URL shortening</small>
                  </div>
                  <div class="col-md-4 text-center mb-3">
                    <div class="feature-icon">📊</div>
                    <h6>Click Tracking</h6>
                    <small class="text-muted">Monitor link performance</small>
                  </div>
                  <div class="col-md-4 text-center mb-3">
                    <div class="feature-icon">🔒</div>
                    <h6>Secure</h6>
                    <small class="text-muted">Safe and secure redirects</small>
                  </div>
                </div>
              </div>
              <div class="card-footer text-center text-muted">
                <small>URL Shortener System © 2025</small>
              </div>
            </div>
          </div>
        </div>
      </div>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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