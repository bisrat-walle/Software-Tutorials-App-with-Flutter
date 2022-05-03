package com.groupproject.softwaretu.apiv1.tutorial;

import com.groupproject.softwaretu.tutorial.Tutorial;
import lombok.Data;
import com.groupproject.softwaretu.enrollement.EnrollementService;


@Data

public class TutorialRepresentationClient extends TutorialRepresentation {
    public boolean enrolled;
    public String submittedLink;
	public int enrollementCount;
    
    public TutorialRepresentationClient(Tutorial tutorial, EnrollementService service){
        super(tutorial);
        this.enrolled = service.check(tutorial);
        this.submittedLink = service.getGithubLink(tutorial);
		this.enrollementCount = service.getEnrollementCount(tutorial);
    }
}
