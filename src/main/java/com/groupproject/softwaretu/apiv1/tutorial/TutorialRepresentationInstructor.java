package com.groupproject.softwaretu.apiv1.tutorial;

import com.groupproject.softwaretu.tutorial.Tutorial;
import lombok.Data;
import com.groupproject.softwaretu.enrollement.EnrollementService;

@Data
public class TutorialRepresentationInstructor extends TutorialRepresentation{
    public boolean isInstructor;
    
    
    public TutorialRepresentationInstructor(Tutorial tutorial, EnrollementService service){
        super(tutorial);
        this.isInstructor = service.checkTutorialInstructor(tutorial);
    }
}
