package com.groupproject.softwaretu.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;



@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
    
    @Autowired
    UserDetailsService userDetailsService;
    
    @Autowired
    PasswordEncoder bCryptPasswordEncoder;
    
    @Autowired
    UserRepository userRepository;

    
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder);
    }
    
    @Override
    protected void configure(HttpSecurity http) throws Exception{
        CustomAuthenticationFilter customAuthenticationFilter = new CustomAuthenticationFilter(authenticationManagerBean());
        customAuthenticationFilter.setFilterProcessesUrl("/api/v1/login");
		http.cors();
        http.csrf().disable();
        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        http.authorizeRequests()
            .antMatchers("/swagger-ui", "/swagger-ui/*", "/swagger-ui/**", "/v3/api-docs", "/api/v1/login").permitAll()
            .antMatchers("/api/v1/tutorials/all", "/api/v1/tutorials/all/c", "/api/v1/profile").authenticated()
            .antMatchers("/api/v1/users", "/api/v1/users/*", "/api/v1/users/**").hasRole("ADMIN")
            .antMatchers("/api/v1/tutorials/enrolled/**", "/api/v1/tutorials/enrolled/*").hasRole("CLIENT")
            .antMatchers("/api/v1/tutorials/enroll/**", "/api/v1/tutorials/enroll/*").hasRole("CLIENT")
            .antMatchers("/api/v1/tutorials/mytutorials/**", "/api/v1/tutorials/mytutorials/*").hasAnyRole("INSTRUCTOR", "ADMIN")
            .antMatchers("/api/v1/login", "/api/v1/register").permitAll()
            .antMatchers("/api/v1/**").authenticated()
            .antMatchers("/*", "/**").permitAll();
        http.addFilter(customAuthenticationFilter);
        http.addFilterBefore(new CustomAuthorizationFilter(), UsernamePasswordAuthenticationFilter.class);
        
    }
	
	



	@Bean 
	CorsConfigurationSource corsConfigurationSource() { 
		CorsConfiguration configuration = new CorsConfiguration(); 
		configuration.setAllowedOrigins(Arrays.asList("*")); 
		configuration.setAllowedMethods(Arrays.asList("GET","POST", "PUT")); 
		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource(); 
		source.registerCorsConfiguration("/**", configuration); 
		return source; 
	}
    
    
    @Override
    @Bean
    public AuthenticationManager authenticationManagerBean() throws Exception{
        return super.authenticationManagerBean();
    }
    
    


    



}


