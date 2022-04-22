package com.groupproject.softwaretu.apiv1.enrollement;

import com.groupproject.softwaretu.tutorial.TutorialRepository;
import com.groupproject.softwaretu.tutorial.Tutorial;

import java.time.LocalDateTime;

import com.groupproject.softwaretu.enrollement.Enrollement;
import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.project.ProjectRepository;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.security.UserService;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;
import com.groupproject.softwaretu.enrollement.EnrollementService;

@RestController
@RequestMapping(path="api/v1/tutorials", produces="application/json")
@CrossOrigin(origins="*")
public class EnrollementRestController {
    
    @Autowired
    private TutorialRepository tutorialRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EnrollementRepository enrollementRepository;
    
    @Autowired 
    private EnrollementService enrollementService;
    
    @Autowired
    private UserService userService;
    
    @PostMapping("/{tutorialId}/enroll")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void enroll( 
                        @PathVariable("tutorialId") Long tutorialId
                        ) {
        
        Tutorial tutorial= tutorialRepository.findByTutorialId(tutorialId);
        if (enrollementService.check(tutorial)){
            return;
        }
        Enrollement newEnrollement = new Enrollement();
        newEnrollement.setEnrolledAt(LocalDateTime.now());

        User client = userService.getAuthenticatedUser();
        newEnrollement.setClient(client);
        newEnrollement.setTutorial(tutorial);
        enrollementRepository.save(newEnrollement);
    }

    @DeleteMapping("/enrolled/{tutorialId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void unenrollTutorial(@PathVariable ("tutorialId") Long tutorialId){
        Tutorial tutorial = tutorialRepository.findByTutorialId(tutorialId);
        User client = userService.getAuthenticatedUser();
        Enrollement enrollement = enrollementRepository.getEnrollementFromClientAndTutorial(
            client, tutorial);
        if (enrollement == null){
            return;
        }
        enrollementRepository.delete(enrollement);
    }
}
