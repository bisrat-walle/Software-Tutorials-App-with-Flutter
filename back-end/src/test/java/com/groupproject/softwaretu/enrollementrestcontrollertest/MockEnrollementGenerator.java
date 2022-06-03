package com.groupproject.softwaretu.enrollementrestcontrollertest;


import com.groupproject.softwaretu.tutorial.Tutorial;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.enrollement.Enrollement;

public class MockEnrollementGenerator{
	public static Enrollement getEnrollement(Tutorial tutorial, User client){
		Enrollement en = new Enrollement();
		en.setEnrollementId(100L);
		en.setClient(client);
		en.setTutorial(tutorial);
		return en;
	}
}