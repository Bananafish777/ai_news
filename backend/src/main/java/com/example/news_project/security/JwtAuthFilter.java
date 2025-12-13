package com.example.news_project.security;
//
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
//import org.springframework.stereotype.Component;
//import org.springframework.web.filter.OncePerRequestFilter;
//
//import java.io.IOException;
//import java.net.http.HttpRequest;
//
//@Component
//public class JwtAuthFilter extends OncePerRequestFilter {
//
//    private final JwtService jwt;
//    private final UserDetailsService uds;
//
//    public JwtAuthFilter(JwtService s, UserDetailsService uds){
//        this.jwt = s;
//        this.uds = uds;
//    }
//
//    @Override
//    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse rsp, FilterChain chain)
//                            throws ServletException, IOException {
//        String auth = req.getHeader("Authorization");
//        if (auth == null || auth.startsWith("Bearer ")) {
//            chain.doFilter(req, rsp);
//            return;
//        }
//
//        String token = auth.substring(7);
//        String subject;
//        try{
//            subject = jwt.extractSubject(token);
//        } catch (Exception e) {
//            chain.doFilter(req, rsp);
//            return;
//        }
//
//        if (subject != null && SecurityContextHolder.getContext().getAuthentication() == null) {
//            UserDetails userDetails = uds.loadUserByUsername(subject);
//            if(jwt.validate(token, userDetails.getUsername())){
//                UsernamePasswordAuthenticationToken authToken =
//                        new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
//                authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
//                SecurityContextHolder.getContext().setAuthentication(authToken);
//            }
//        }
//        chain.doFilter(req, rsp);
//
//    }
//}
// package com.example.news.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
public class JwtAuthFilter extends OncePerRequestFilter {

    private final JwtService jwt;
    private final UserDetailsService uds;

    public JwtAuthFilter(JwtService jwt, UserDetailsService uds) {
        this.jwt = jwt; this.uds = uds;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws ServletException, IOException {

        String auth = req.getHeader("Authorization");
        if (auth == null || !auth.startsWith("Bearer ")) {
            chain.doFilter(req, res);
            return;
        }

        String token = auth.substring(7);

        try {
            Claims claims = jwt.parse(token).getBody();
            String email = claims.getSubject();

            Number idNum = claims.get("id", Number.class);
            Long userId = idNum != null ? idNum.longValue() : null;

            String role = claims.get("role", String.class);
            String roleName = role == null ? "USER" : null;

            List<GrantedAuthority> auths = List.of(new SimpleGrantedAuthority("ROLE_"+roleName));

            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                UserDetails user = uds.loadUserByUsername(email);
                if (jwt.validate(token, user.getUsername())) {
                    UserPrincipal principal = new UserPrincipal(userId, email, null, auths);
                    UsernamePasswordAuthenticationToken authToken =
                            new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
                    SecurityContextHolder.getContext().setAuthentication(authToken);
                }
            }


        } catch (Exception e) {
            chain.doFilter(req, res);
            return;
        }

        chain.doFilter(req, res);
    }
}
