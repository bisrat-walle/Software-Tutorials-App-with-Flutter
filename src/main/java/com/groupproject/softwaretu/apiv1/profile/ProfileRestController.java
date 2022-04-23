package com.groupproject.softwaretu.apiv1.profile;

import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.security.RegistrationForm;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.security.crypto.password.PasswordEncoder;
import lombok.extern.slf4j.Slf4j;
import com.groupproject.softwaretu.security.UserService;
import org.springframework.http.HttpHeaders;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping(path="api/v1", produces="application/json")
@CrossOrigin(origins = "*")
@Slf4j
public class ProfileRestController {
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	UserService userService;
	
	@PostMapping("/register")
    public ResponseEntity<User> processRegistration(@RequestBody User user){
        
		if (userService.isUsernameExist(user.getUsername())){
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.set("error", "Username already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.CONFLICT);
		}
		
		if (userService.isEmailExist(user.getEmail())){
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.set("error", "Email already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.CONFLICT);
		}
		
		RegistrationForm form = new RegistrationForm();
		
		return new ResponseEntity<>(
			userRepository.save(form.getUser(user, passwordEncoder)), HttpStatus.CREATED);
    }
	
	@PutMapping("/profile/")
	@Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<User> updateProfile(@RequestBody ProfileUpdate newUser){
		
		User user = userService.getAuthenticatedUser();
		if (userService.isUsernameExist(newUser.username)){
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.set("error", "Username already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.BAD_REQUEST);
		}
		
		if (userService.isEmailExist(newUser.email)){
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.set("error", "Email already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.BAD_REQUEST);
		}
		
		RegistrationForm form = new RegistrationForm();
		return new ResponseEntity<>(
			userRepository.save(form.getUpdatedUser(user, newUser ,passwordEncoder)), 
			HttpStatus.OK);
    }
	
}