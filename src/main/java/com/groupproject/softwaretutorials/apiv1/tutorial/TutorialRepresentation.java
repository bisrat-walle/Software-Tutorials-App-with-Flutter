package com.groupproject.softwaretu.apiv1.tutorial;

import com.groupproject.softwaretu.tutorial.Tutorial;
import lombok.Data;


@Data
public class TutorialRepresentation {
    public Long tutorialId;
    public String title;
    public String content;
    
    public TutorialRepresentation(Tutorial tutorial){
        this.tutorialId = tutorial.getTutorialId();
        this.title = tutorial.getTitle();
        this.content = tutorial.getContent();
    }
}
