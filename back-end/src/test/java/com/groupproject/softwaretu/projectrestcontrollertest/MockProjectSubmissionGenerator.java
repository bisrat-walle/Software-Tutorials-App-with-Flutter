package com.groupproject.softwaretu.projectrestcontrollertest;

import com.groupproject.softwaretu.apiv1.project.ProjectSubmission;

public class MockProjectSubmissionGenerator{
	public static ProjectSubmission get(String gitHubLink){
		ProjectSubmission pro = new ProjectSubmission();
		pro.projectUrl = gitHubLink;
		return pro;
	}
}

