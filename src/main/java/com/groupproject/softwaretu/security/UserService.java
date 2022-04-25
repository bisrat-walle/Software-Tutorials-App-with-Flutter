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
        return userRepository.findByUsername(username) != null;
    }
    
    public boolean isEmailExist(String email){
        return userRepository.findByEmail(email) != null;
    }
}
