package com.groupproject.softwaretu.apiv1.profile;

import lombok.Data;
import com.groupproject.softwaretu.security.User;

@Data
public class LoginResponse {
    private String username;
    private String role;
    private String accessToken;
    public LoginResponse(User user){
        this.username = user.getUsername();
        this.role = user.getRole();
    }
}