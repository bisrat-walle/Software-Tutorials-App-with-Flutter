package com.groupproject.softwaretu.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class UserService {
    
    @Autowired
    private UserRepository userRepository;

    public User getAuthenticatedUser() {
        String username = SecurityContextHolder.getContext().getAuthentication().getPrincipal().toString();
        return userRepository.findByUsername(username);
    }
    
    public boolean isUsernameExist(String username){
		User user = userRepository.findByUsername(username);
        return user != null && user != getAuthenticatedUser();
    }
    
    public boolean isEmailExist(String email){
		User user = userRepository.findByEmail(email);
        return user != null && user != getAuthenticatedUser();
    }
}
