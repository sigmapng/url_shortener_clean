package com.urlshortener.servlet;

import com.urlshortener.model.UrlMapping;
import com.urlshortener.service.UrlService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/r/*")
public class RedirectServlet extends HttpServlet {

  @Inject
  private UrlService urlService;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    String pathInfo = request.getPathInfo();
    if (pathInfo == null || pathInfo.length() <= 1) {
      response.sendError(HttpServletResponse.SC_NOT_FOUND);
      return;
    }

    String shortCode = pathInfo.substring(1); // Remove leading slash

    UrlMapping urlMapping = urlService.findByShortCode(shortCode);
    if (urlMapping == null) {
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Short URL not found");
      return;
    }

    // Increment click count
    urlService.incrementClickCount(shortCode);

    // Redirect to original URL
    response.sendRedirect(urlMapping.getOriginalUrl());
  }
}
