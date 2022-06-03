package com.groupproject.softwaretu.apiv1.tutorial;

import com.groupproject.softwaretu.tutorial.TutorialRepository;
import com.groupproject.softwaretu.tutorial.TutorialService;
import com.groupproject.softwaretu.tutorial.Tutorial;

import java.time.LocalDateTime;

import com.groupproject.softwaretu.enrollement.Enrollement;
import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.project.ProjectRepository;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;

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
import org.springframework.security.core.context.SecurityContextHolder;
import lombok.extern.slf4j.Slf4j;
import com.groupproject.softwaretu.enrollement.EnrollementService;
import com.groupproject.softwaretu.security.UserService;
import com.groupproject.softwaretu.project.Project;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping(path="api/v1/tutorials", produces="application/json")
@CrossOrigin(origins = "*")
@Slf4j
public class TutorialRestController {
    
    
    @Autowired
    private TutorialRepository tutorialRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EnrollementRepository enrollementRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private TutorialService tutorialService;
    
    @Autowired 
    private EnrollementService enrollementService;
    
    @Autowired
    private UserService userService;

    
    @GetMapping("/all")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<Iterable<Tutorial>> getAllTutorials(){
        return new ResponseEntity<>(tutorialRepository.findAll(), HttpStatus.OK);
    }
    
    @GetMapping("/all/c")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<Iterable<TutorialRepresentationClient>> getAllTutorialsClient(){
        ArrayList<TutorialRepresentationClient> tutorialReps = new ArrayList<>(); 
        
        Iterable<Tutorial> tutorials = tutorialRepository.findAll();
        for (Tutorial tutorial: tutorials){
            tutorialReps.add(new TutorialRepresentationClient(tutorial, enrollementService));
        }
        return new ResponseEntity<>(tutorialReps, HttpStatus.OK);
    }

    @GetMapping("/enrolled")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<Iterable<TutorialRepresentationClient>> getEnrolledTutorials(){
        User user = userService.getAuthenticatedUser();
		
		ArrayList<TutorialRepresentationClient> tutorialReps = new ArrayList<>(); 
        
        Iterable<Tutorial> tutorials = enrollementRepository.getEnrolledTutorials(user);
        for (Tutorial tutorial: tutorials){
            tutorialReps.add(new TutorialRepresentationClient(tutorial, enrollementService));
        }
        return new ResponseEntity<>(tutorialReps, HttpStatus.OK);
    }

    @GetMapping("/mytutorials")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<Iterable<TutorialRepresentationClient>> getMyTutorials(){
        User user = userService.getAuthenticatedUser();
		
		ArrayList<TutorialRepresentationClient> tutorialReps = new ArrayList<>(); 
        
        Iterable<Tutorial> tutorials = tutorialRepository.getInstructorTutorials(user);
        for (Tutorial tutorial: tutorials){
            tutorialReps.add(new TutorialRepresentationClient(tutorial, enrollementService));
        }
        return new ResponseEntity<>(tutorialReps, HttpStatus.OK);
    }

    @PostMapping(path="/", consumes="application/json")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    @ResponseStatus(HttpStatus.CREATED)
    public Tutorial createTutorial(@RequestBody Tutorial tutorial){
        Project project = projectRepository.save(tutorial.getProject());
        User user = userService.getAuthenticatedUser();
        tutorial.setInstructor(user);
        tutorial.setProject(project);
        return tutorialRepository.save(tutorial);
    }


    @PutMapping(path="/{tutorialId}", consumes="application/json")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    @ResponseStatus(HttpStatus.OK)
    public Tutorial updateTutorial(@PathVariable ("tutorialId") Long tutorialId,
        @RequestBody Tutorial tutorial
    ){
        Tutorial oldTutorial = tutorialRepository.findByTutorialId(tutorialId);
        oldTutorial.getProject().setTitle(tutorial.getProject().getTitle());
        oldTutorial.getProject().setProblemStatement(tutorial.getProject().getProblemStatement());
        projectRepository.save(oldTutorial.getProject());
        oldTutorial.setTitle(tutorial.getTitle());
        oldTutorial.setContent(tutorial.getContent());
        return tutorialRepository.save(oldTutorial);
    }

    @DeleteMapping(path="/{tutorialId}")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteTutorial(@PathVariable ("tutorialId") Long tutorialId){
        tutorialService.deleteTutorialCascadeProject(tutorialId);
    }


    @GetMapping("/{tutorialId}")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<TutorialRepresentationClient> getTutorialDetailsById(@PathVariable("tutorialId") Long tutorialId){
        return new ResponseEntity<>(new TutorialRepresentationClient(tutorialRepository.findByTutorialId(tutorialId), enrollementService), HttpStatus.OK);
    }
    

}
