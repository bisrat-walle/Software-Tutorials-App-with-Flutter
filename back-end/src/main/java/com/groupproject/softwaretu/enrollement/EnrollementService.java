package com.groupproject.softwaretu.enrollement;

import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.security.UserService;
import com.groupproject.softwaretu.tutorial.Tutorial;
import com.groupproject.softwaretu.tutorial.TutorialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class EnrollementService {
    @Autowired
    private EnrollementRepository enrollementRepository;

    @Autowired
    private TutorialRepository tutorialRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private UserService userService;

    public boolean check(Tutorial tutorial) {
        User user = userService.getAuthenticatedUser();
        return enrollementRepository.getEnrollementFromClientAndTutorial(user, tutorial) != null;
    }

    public boolean checkGithubLink(Tutorial tutorial) {
        User user = userService.getAuthenticatedUser();
        return enrollementRepository.getGithubLinkFromClientAndTutorial(user, tutorial) == null;
    }
    
    public String getGithubLink (Tutorial tutorial){
        User user = userService.getAuthenticatedUser();
        return enrollementRepository.getGithubLinkFromClientAndTutorial(user, tutorial);
    }

    public boolean checkTutorialInstructor(Tutorial tutorial) {
        User instructor = userService.getAuthenticatedUser();
        return tutorialRepository.getInstructor(tutorial).equals(instructor);
    }
	
	public int getEnrollementCount(Tutorial tutorial){
		return enrollementRepository.getEnrollementFromTutorial(tutorial).size();
	}
}
