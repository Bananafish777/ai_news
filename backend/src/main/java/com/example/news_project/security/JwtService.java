package com.example.news_project.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;
import java.time.Instant;
import java.util.Map;

@Service
public class JwtService {

    private final Key key;
    private final long expMins;

    public JwtService(@Value("${app.jwt.secret}") String secret,
                      @Value("${app.jwt.exp-minutes}") long expiration) {
        // 建议 secret 至少 32 字节（256 bit）以支持 HS256
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.expMins = expiration;
    }

    public String generate(String subject, Map<String, Object> claims) {
        Instant now = Instant.now();
        return Jwts.builder()
                .setSubject(subject)
                .addClaims(claims)
                .setIssuedAt(Date.from(now))
                .setExpiration(Date.from(now.plusSeconds(expMins * 60)))
                .signWith(key, SignatureAlgorithm.HS256)   // 或者 .signWith(key) 也可（0.11.x）
                .compact();
    }

    public boolean validate(String token, String subject) {
        try {
            return subject.equals(extractSubject(token)) && !isExpired(token);
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isExpired(String token) {
        Date exp = parse(token).getBody().getExpiration();
        return exp.before(new Date());
    }

    public Jws<Claims> parse(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token);
    }

    public String extractSubject(String token) {
        return parse(token).getBody().getSubject();
    }
}
