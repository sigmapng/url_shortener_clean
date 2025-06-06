package com.urlshortener.model;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "url_mappings")
public class UrlMapping {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false, length = 2048)
  private String originalUrl;

  @Column(nullable = false, unique = true, length = 10)
  private String shortCode;
  @Column(name = "createdat", nullable = false)
  private LocalDateTime createdAt;

  @Column(nullable = false)
  private Long clickCount = 0L;

  public UrlMapping() {
    this.createdAt = LocalDateTime.now();
  }

  public UrlMapping(String originalUrl, String shortCode) {
    this();
    this.originalUrl = originalUrl;
    this.shortCode = shortCode;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getOriginalUrl() {
    return originalUrl;
  }

  public void setOriginalUrl(String originalUrl) {
    this.originalUrl = originalUrl;
  }

  public String getShortCode() {
    return shortCode;
  }

  public void setShortCode(String shortCode) {
    this.shortCode = shortCode;
  }

  public LocalDateTime getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(LocalDateTime createdAt) {
    this.createdAt = createdAt;
  }

  public Long getClickCount() {
    return clickCount;
  }

  public void setClickCount(Long clickCount) {
    this.clickCount = clickCount;
  }

  public void incrementClickCount() {
    this.clickCount++;
  }
}
