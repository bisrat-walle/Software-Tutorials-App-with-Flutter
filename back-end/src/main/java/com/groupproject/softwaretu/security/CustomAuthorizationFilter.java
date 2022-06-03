package com.groupproject.softwaretu.security;

import java.io.IOException;

import org.springframework.web.filter.OncePerRequestFilter;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.interfaces.DecodedJWT;
import java.util.Collection;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import java.util.ArrayList;


import lombok.extern.slf4j.Slf4j; 


@Slf4j
public class CustomAuthorizationFilter extends OncePerRequestFilter{
    @Override
    protected void doFilterInternal(HttpServletRequest request, 
                HttpServletResponse response, FilterChain filterChain) throws
                ServletException, IOException{
                    
                    log.info("trying to authorize" + " path "+ request.getServletPath());
                    
                    
                    if (request.getServletPath().equals("/api/v1/login") || 
                        request.getServletPath().equals("/api/v1/register") || 
                        request.getServletPath().contains("swagger") ||
                        request.getServletPath().equals("/v3/api-docs")){
                        filterChain.doFilter(request, response);
                        return;
                    } 
                    String authHeader = request.getHeader("Authorization");
                    log.info("Header " + authHeader);
                    if (authHeader != null && authHeader.startsWith("Bearer ")){
                        try{
                            String token = authHeader.substring(7);
                            Algorithm algorithm = Algorithm.HMAC256("my secret".getBytes());
                            JWTVerifier verifier = JWT.require(algorithm).build();
                            DecodedJWT  decoded = verifier.verify(token);
                            String username = decoded.getSubject();
                            String[] roles = decoded.getClaim("roles").asArray(String.class);
                            Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
                            for(String role: roles){
                                authorities.add(new SimpleGrantedAuthority(role));
                            }
                            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
                                username, null, authorities
                            );
                            SecurityContextHolder.getContext().setAuthentication(auth);   
                            filterChain.doFilter(request, response);
                        } catch(Exception ex){
                            response.setHeader("error", ex.getMessage());
                            response.setStatus(401);
                            filterChain.doFilter(request, response);
                        }

                    } else{
                        response.setHeader("error", "Authentication Credential Not Provided");
                        response.setStatus(401);
                        filterChain.doFilter(request, response);
                    }
                }
}
