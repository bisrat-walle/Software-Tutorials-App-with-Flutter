package com.groupproject.softwaretu.security;

import org.springframework.security.crypto.password.PasswordEncoder;
import com.groupproject.softwaretu.apiv1.profile.ProfileUpdate;

import lombok.Data;

@Data
public class RegistrationForm {

    public User getUser(User user, PasswordEncoder encoder) {
        user.setPassword(encoder.encode(user.getPassword()));
        return user;
    }
    
    public User getUpdatedUser(User old, ProfileUpdate newUser, PasswordEncoder encoder){
        old.setUsername(newUser.username);
        old.setFullName(newUser.fullName);
        old.setPassword(encoder.encode(newUser.password));
        old.setEmail(newUser.email);
        
        return old;
        
    }
    
    
}
