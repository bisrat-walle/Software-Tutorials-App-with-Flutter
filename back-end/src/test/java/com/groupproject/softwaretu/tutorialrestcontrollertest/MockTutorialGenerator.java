package com.groupproject.softwaretu.tutorialrestcontrollertest;
import java.util.*;
import com.groupproject.softwaretu.tutorial.Tutorial;
import com.groupproject.softwaretu.project.Project;

public class MockTutorialGenerator{
	
	
	public static ArrayList<Tutorial> getTutorials(){
		Tutorial tutorial1 = new Tutorial();
		tutorial1.setTutorialId(53409L);
		tutorial1.setTitle("Tutorial 1");
		tutorial1.setContent("fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj");
		Tutorial tutorial2 = new Tutorial();
		tutorial2.setTutorialId(789L);
		tutorial2.setTitle("Tutorial 2");
		tutorial2.setContent("fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj");
		tutorial2.setProject(new Project(980L, "kdjffls", "fjsdlj"));
		Tutorial tutorial3 = new Tutorial();
		tutorial3.setTutorialId(7898L);
		tutorial3.setTitle("Tutorial 3");
		tutorial3.setContent("fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj");
		tutorial3.setProject(new Project(78987L, "kdjffls", "fjsdlj"));
		
		ArrayList<Tutorial> tutorials = new ArrayList<>();
		tutorials.add(tutorial1);
		tutorials.add(tutorial2);
		tutorials.add(tutorial3);
		
		return tutorials;
		
	}
}