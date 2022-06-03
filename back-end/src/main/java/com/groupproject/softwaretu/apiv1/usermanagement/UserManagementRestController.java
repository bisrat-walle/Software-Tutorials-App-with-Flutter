package com.groupproject.softwaretu.apiv1.usermanagement;

import com.groupproject.softwaretu.enrollement.Enrollement;
import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.tutorial.Tutorial;
import com.groupproject.softwaretu.tutorial.TutorialRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;

@CrossOrigin("*")
@RestController
@Slf4j
@RequestMapping("api/v1/users/")
public class UserManagementRestController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    EnrollementRepository enrollementRepository;

    @Autowired
    TutorialRepository tutorialRepository;

    @GetMapping
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    ResponseEntity<Iterable<User>> getAllUsers(){
        return new ResponseEntity<>(userRepository.findAll(), HttpStatus.OK);
    }

    @DeleteMapping("{username}")
    @ResponseStatus(HttpStatus.OK)
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    void deleteUser(@PathVariable("username") String username){
        User user = userRepository.findByUsername(username);
        if (user != null){
            if (user.getRole().equals("CLIENT")){
                Collection<Enrollement> enrollements = enrollementRepository.getEnrollementFromClient(user);
                for(Enrollement enrollement: enrollements){
                    enrollementRepository.delete(enrollement);
                }
            }
            if (user.getRole().equals("INSTRUCTOR")){
                Collection<Tutorial> tutorials = tutorialRepository.getInstructorTutorials(user);
                for(Tutorial tutorial: tutorials){
                    tutorialRepository.delete(tutorial);
                }
            }
            userRepository.delete(user);
        }
    }

}
