package com.groupproject.softwaretu.apiv1.profile;

import com.groupproject.softwaretu.security.RegistrationForm;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.security.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

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
			user.setFullName("Username already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.CONFLICT);
		}
		
		if (userService.isEmailExist(user.getEmail())){
			HttpHeaders responseHeaders = new HttpHeaders();
			user.setFullName("Email already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.CONFLICT);
		}
		
		RegistrationForm form = new RegistrationForm();
		
		return new ResponseEntity<>(
			userRepository.save(form.getUser(user, passwordEncoder)), HttpStatus.CREATED);
    }
	
	@GetMapping("/profile")
	@Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<User> getProfile(){
		
		User user = userService.getAuthenticatedUser();
		return new ResponseEntity<>(userRepository.findByUsername(user.getUsername()), HttpStatus.OK);
	}
	
	@PutMapping("/profile")
	@Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<User> updateProfile(@RequestBody ProfileUpdate newUser){
		
		User user = userService.getAuthenticatedUser();
		if (userService.isUsernameExist(newUser.username)){
			HttpHeaders responseHeaders = new HttpHeaders();
			user.setFullName("Username already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.BAD_REQUEST);
		}
		
		if (userService.isEmailExist(newUser.email)){
			HttpHeaders responseHeaders = new HttpHeaders();
			user.setFullName("Email already taken");
			return new ResponseEntity<>(user, responseHeaders, HttpStatus.BAD_REQUEST);
		}
		
		RegistrationForm form = new RegistrationForm();
		return new ResponseEntity<>(
			userRepository.save(form.getUpdatedUser(user, newUser ,passwordEncoder)), 
			HttpStatus.OK);
    }
	
}
