package com.groupproject.softwaretu;

import java.beans.Encoder;

import com.groupproject.softwaretu.security.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.tutorial.Tutorial;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.web.bind.annotation.CrossOrigin;



@SpringBootApplication
@CrossOrigin(origins="*")
public class SoftwaretuApplication {

	public static void main(String[] args) {
		SpringApplication.run(SoftwaretuApplication.class, args);
	}
	
	@Bean
	 public OpenAPI customOpenAPI() {
	   return new OpenAPI()
			  .components(new Components()
			  .addSecuritySchemes("bearer-key",
			  new SecurityScheme().type(SecurityScheme.Type.HTTP).scheme("bearer").bearerFormat("JWT")));
	}


	@Bean
	public CommandLineRunner dataLoader(UserRepository repo) {
		return args -> {

		};
	}
	
	@Bean
    public PasswordEncoder bcryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	@Bean
    UserDetailsService userDetailsService(UserRepository userRepo){
        return username -> {
            User user = userRepo.findByUsername(username);
            if (user == null){
                throw new UsernameNotFoundException(
                    "User with username "+username+" doesnot exist"
                );
            }
            return user;
        };
        

    }
	

}
