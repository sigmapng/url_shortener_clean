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

@WebServlet("/shorten")
public class ShortenUrlServlet extends HttpServlet {

  @Inject
  private UrlService urlService;

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    String originalUrl = request.getParameter("url");

    try {
      UrlMapping urlMapping = urlService.createShortUrl(originalUrl);

      // Build short URL
      String baseUrl = request.getScheme() + "://" + request.getServerName() +
          ":" + request.getServerPort() + request.getContextPath();
      String shortUrl = baseUrl + "/r/" + urlMapping.getShortCode();

      request.setAttribute("shortUrl", shortUrl);
      request.setAttribute("originalUrl", urlMapping.getOriginalUrl());
      request.setAttribute("success", true);

    } catch (Exception e) {
      request.setAttribute("error", "Error creating short URL: " + e.getMessage());
    }

    request.getRequestDispatcher("/index.jsp").forward(request, response);
  }
}
