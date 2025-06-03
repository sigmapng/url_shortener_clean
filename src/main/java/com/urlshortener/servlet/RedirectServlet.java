package com.urlshortener.servlet;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urlshortener.model.UrlMapping;
import com.urlshortener.service.UrlService;

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

    String shortCode = pathInfo.substring(1);

    UrlMapping urlMapping = urlService.findByShortCode(shortCode);
    if (urlMapping == null) {
      response.sendError(HttpServletResponse.SC_NOT_FOUND, "Short URL not found");
      return;
    }

    urlService.incrementClickCount(shortCode);

    response.sendRedirect(urlMapping.getOriginalUrl());
  }
}
