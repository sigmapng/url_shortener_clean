package com.urlshortener.service;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import com.urlshortener.model.UrlMapping;
import com.urlshortener.util.ShortCodeGenerator;

@Stateless
public class UrlService {

  @PersistenceContext(unitName = "url-shortener-pu")
  private EntityManager em;

  public UrlMapping createShortUrl(String originalUrl) {
    if (originalUrl == null || originalUrl.trim().isEmpty()) {
      throw new IllegalArgumentException("URL cannot be empty");
    }

    if (!originalUrl.startsWith("http://") && !originalUrl.startsWith("https://")) {
      originalUrl = "https://" + originalUrl;
    }

    UrlMapping existing = findByOriginalUrl(originalUrl);
    if (existing != null) {
      return existing;
    }

    String shortCode;
    do {
      shortCode = ShortCodeGenerator.generateShortCode();
    } while (findByShortCode(shortCode) != null);

    UrlMapping urlMapping = new UrlMapping(originalUrl, shortCode);
    em.persist(urlMapping);
    return urlMapping;
  }

  public UrlMapping findByShortCode(String shortCode) {
    try {
      TypedQuery<UrlMapping> query = em.createQuery(
          "SELECT u FROM UrlMapping u WHERE u.shortCode = :shortCode", UrlMapping.class);
      query.setParameter("shortCode", shortCode);
      return query.getSingleResult();
    } catch (NoResultException e) {
      return null;
    }
  }

  public UrlMapping findByOriginalUrl(String originalUrl) {
    try {
      TypedQuery<UrlMapping> query = em.createQuery(
          "SELECT u FROM UrlMapping u WHERE u.originalUrl = :originalUrl", UrlMapping.class);
      query.setParameter("originalUrl", originalUrl);
      return query.getSingleResult();
    } catch (NoResultException e) {
      return null;
    }
  }

  public void incrementClickCount(String shortCode) {
    UrlMapping urlMapping = findByShortCode(shortCode);
    if (urlMapping != null) {
      urlMapping.incrementClickCount();
      em.merge(urlMapping);
    }
  }
}
