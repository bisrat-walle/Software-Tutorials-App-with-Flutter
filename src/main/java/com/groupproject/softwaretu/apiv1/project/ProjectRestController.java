package com.groupproject.softwaretu.apiv1.project;

import com.groupproject.softwaretutorials.tutorial.TutorialRepository;
import com.groupproject.softwaretutorials.tutorial.TutorialService;
import com.groupproject.softwaretutorials.tutorial.Tutorial;

import java.time.LocalDateTime;

import com.groupproject.softwaretutorials.enrollement.Enrollement;
import com.groupproject.softwaretutorials.enrollement.EnrollementRepository;
import com.groupproject.softwaretutorials.project.ProjectRepository;
import com.groupproject.softwaretutorials.security.User;
import com.groupproject.softwaretutorials.security.UserRepository;

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
import java.util.ArrayList;
import lombok.extern.slf4j.Slf4j;
import com.groupproject.softwaretutorials.enrollement.EnrollementService;
import com.groupproject.softwaretutorials.security.UserService;
import com.groupproject.softwaretutorials.project.Project;

@RestController
@RequestMapping(path="api/v1/tutorials", produces="application/json")
@CrossOrigin(origins = "*")
@Slf4j
public class ProjectRestController {
    
    
    @Autowired
    private TutorialRepository tutorialRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EnrollementRepository enrollementRepository;

    @Autowired
    private TutorialService tutorialService;
    
    @Autowired 
    private EnrollementService enrollementService;
    
    @Autowired
    private UserService userService;

    @PostMapping("/{tutorialId}/project")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void submitProject(
                    @PathVariable("tutorialId") Long tutorialId, 
                    @RequestBody ProjectSubmission project){
        
        
        User user = userService.getAuthenticatedUser();
        
        Enrollement enrollement = enrollementRepository.
                    getEnrollementFromClientAndTutorial(
                    user, tutorialRepository.findByTutorialId(tutorialId));
        
        enrollement.setGithubLink(project.projectUrl);
        enrollementRepository.save(enrollement);
    }
    
    @PutMapping("/{tutorialId}/project")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void editProject(
                    @PathVariable("tutorialId") Long tutorialId, 
                    @RequestBody ProjectSubmission project){
        
        
        User user = userService.getAuthenticatedUser();
        
        Enrollement enrollement = enrollementRepository.
                    getEnrollementFromClientAndTutorial(
                    user, tutorialRepository.findByTutorialId(tutorialId));
        
        enrollement.setGithubLink(project.projectUrl);
        enrollementRepository.save(enrollement);
    }
    
    @DeleteMapping("/{tutorialId}/project")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteProject(
                    @PathVariable("tutorialId") Long tutorialId){
        
        
        User user = userService.getAuthenticatedUser();
        
        Enrollement enrollement = enrollementRepository.
                    getEnrollementFromClientAndTutorial(
                    user, tutorialRepository.findByTutorialId(tutorialId));
        
        enrollement.setGithubLink(null);
        enrollementRepository.save(enrollement);
    }

    

}
