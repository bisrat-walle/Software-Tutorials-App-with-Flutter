package com.groupproject.softwaretu.security;

import com.fasterxml.jackson.databind.ObjectMapper;
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
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationServiceException;
import com.groupproject.softwaretu.apiv1.profile.LoginResponse;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import javax.servlet.Filter;
import javax.servlet.FilterConfig;
import javax.servlet.ServletResponse;
import javax.servlet.ServletRequest;
import org.springframework.http.HttpMethod;
import org.springframework.core.Ordered;

import java.util.*;

import java.time.LocalDateTime;
import com.auth0.jwt.algorithms.Algorithm;
import java.util.stream.Collectors; 
import com.auth0.jwt.JWT;
import org.springframework.security.core.GrantedAuthority;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthenticationFilter extends UsernamePasswordAuthenticationFilter{
    
    private final AuthenticationManager authenticationManager;
    
    public CustomAuthenticationFilter(AuthenticationManager authenticationManager){
        this.authenticationManager = authenticationManager;
    }
    
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
        
        throws AuthenticationException{
        
        log.info("trying to authenticate");
        
        String username, password;

        try {
            Map<String, String> requestMap = new ObjectMapper().readValue(request.getInputStream(), Map.class);
            username = requestMap.get("username");
            password = requestMap.get("password");
            
        } catch (IOException e) {
            throw new AuthenticationServiceException(e.getMessage(), e);
        }
        
        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
            username, password
        );
        
        return authenticationManager.authenticate(authToken);
        
    }
    
    
    @Override
    public void successfulAuthentication(HttpServletRequest request, 
                HttpServletResponse response, FilterChain chain, Authentication authResult) throws
                ServletException, IOException{
        User user = (User) authResult.getPrincipal();
        
        log.info("Authentication successful!");
        
        Algorithm algorithm = Algorithm.HMAC256("my secret".getBytes());
		String accessToken = JWT.create()
								.withSubject(user.getUsername())
								.withExpiresAt(new Date(System.currentTimeMillis() + 60*60*1000))
								.withClaim("roles", user.getAuthorities().stream().map(
									GrantedAuthority::getAuthority).collect(Collectors.toList())
								)
								.sign(algorithm);
		LoginResponse res = new LoginResponse(user);
		res.setAccessToken(accessToken);	

        response.setContentType("application/json");
        new ObjectMapper().writeValue(response.getOutputStream(), res);
        
    }
    
    
}


