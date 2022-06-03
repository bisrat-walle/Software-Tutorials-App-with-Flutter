package com.groupproject.softwaretu.security;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import java.util.Collection;


public interface UserRepository extends CrudRepository<User, Long> {
    public User findByUsername(String username);
    
    public User findByEmail(String email);

//    public User findByResetPasswordToken(String token);

    @Query("SELECT u FROM User u WHERE u.role = ?#{[0]}")
    Collection<User> getUserOfType(String role);
    
    @Query("SELECT u FROM User u WHERE u.email = ?#{[0]}")
    Collection<User> getUserWithEmail(String email);
    
    @Query("SELECT u FROM User u WHERE u.username = ?#{[0]}")
    Collection<User> getUserWithUsername(String username);

    
}

