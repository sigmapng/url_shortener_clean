package com.urlshortener.servlet;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urlshortener.model.UrlMapping;
import com.urlshortener.service.UrlService;

@WebServlet("/shorten")
public class ShortenUrlServlet extends HttpServlet {

  @EJB
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
