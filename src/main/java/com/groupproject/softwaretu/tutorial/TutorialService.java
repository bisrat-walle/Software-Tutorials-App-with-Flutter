package com.groupproject.softwaretu.tutorial;

import com.groupproject.softwaretu.enrollement.Enrollement;
import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.project.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.groupproject.softwaretu.project.Project;


@Service
public class TutorialService {
    @Autowired
    TutorialRepository tutorialRepository;
    @Autowired
    ProjectRepository projectRepository;
    @Autowired
    EnrollementRepository enrollementRepository;

    public void deleteTutorialCascadeProject(Long id){
        Tutorial tutorial = tutorialRepository.findByTutorialId(id);
        if (tutorial == null){
            return;
        }
        Project project = tutorial.getProject();
        tutorial.setProject(null);
        if ( project != null){
            projectRepository.deleteById(project.getProjectId());
        }

        enrollementRepository.getEnrollementFromTutorial(tutorial).forEach(
                i -> {
                    i.setClient(null);
                    enrollementRepository.delete(i);
                }
        );

        tutorialRepository.deleteByTutorialId(id);
    }
}
