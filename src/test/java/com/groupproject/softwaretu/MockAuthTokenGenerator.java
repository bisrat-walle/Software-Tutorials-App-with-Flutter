package com.groupproject.softwaretu;

import java.util.stream.Collectors;
import com.auth0.jwt.JWT;
import org.springframework.security.core.GrantedAuthority;
import com.auth0.jwt.algorithms.Algorithm;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import java.util.*;


public class MockAuthTokenGenerator {

	public static String getToken(String username){
		Algorithm algorithm = Algorithm.HMAC256("my secret".getBytes());
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
		authorities.add(new SimpleGrantedAuthority("ROLE_CLIENT"));
		authorities.add(new SimpleGrantedAuthority("ROLE_INSTRUCTOR"));
		String accessToken = JWT.create()
								.withSubject(username)
								.withExpiresAt(new Date(System.currentTimeMillis() + 30*60*1000))
								.withClaim("roles", authorities.stream().map(
									GrantedAuthority::getAuthority).collect(Collectors.toList()))
								.sign(algorithm);
		return accessToken;
	}

}
