package com.groupproject.softwaretu.apiv1.project;

import com.groupproject.softwaretu.enrollement.Enrollement;
import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.enrollement.EnrollementService;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.security.UserService;
import com.groupproject.softwaretu.tutorial.TutorialRepository;
import com.groupproject.softwaretu.tutorial.TutorialService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

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
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
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
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
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
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
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
