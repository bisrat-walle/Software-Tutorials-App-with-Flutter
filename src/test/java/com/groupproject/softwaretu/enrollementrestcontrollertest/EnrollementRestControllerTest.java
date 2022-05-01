package com.groupproject.softwaretu.enrollementrestcontrollertest;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.containsString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import com.groupproject.softwaretu.tutorial.Tutorial;
import com.groupproject.softwaretu.tutorial.TutorialRepository;
import com.groupproject.softwaretu.apiv1.enrollement.EnrollementRestController;
import com.groupproject.softwaretu.project.Project;

import static org.mockito.Mockito.verify;
import org.mockito.Mockito;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.*;
import org.springframework.http.MediaType;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import static org.hamcrest.Matchers.*;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
//import static org.hamcrest.CoreMatchers.*;
import com.groupproject.softwaretu.MockAuthTokenGenerator;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.enrollement.EnrollementService;
import com.groupproject.softwaretu.enrollement.Enrollement;
import com.groupproject.softwaretu.project.ProjectRepository;
import com.groupproject.softwaretu.tutorial.TutorialService;
import com.groupproject.softwaretu.security.UserService;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import com.groupproject.softwaretu.apiv1.project.ProjectSubmission;
import com.groupproject.softwaretu.tutorialrestcontrollertest.MockTutorialGenerator;
import com.groupproject.softwaretu.profilerestcontrollertest.MockUserGenerator;
import com.groupproject.softwaretu.enrollementrestcontrollertest.MockEnrollementGenerator;
import com.groupproject.softwaretu.projectrestcontrollertest.MockProjectSubmissionGenerator;
import com.groupproject.softwaretu.security.User;

@WebMvcTest(EnrollementRestController.class)
public class EnrollementRestControllerTest {
    @Autowired
    MockMvc mockMvc;
	
    @Autowired
    ObjectMapper mapper;
    
    @MockBean
    TutorialRepository tutorialRepository;
	
	@MockBean
	UserRepository userRepository;
	
	@MockBean
	EnrollementRepository enrollementRepository;
	
	@MockBean
	EnrollementService enrollementService;
	
	@MockBean
	ProjectRepository projectRepository;
	
	@MockBean
	TutorialService tutorialService;
    
	@MockBean
	UserService userService;
	
	@Test
	public void enroll() throws Exception {
		
		Tutorial tutorial = MockTutorialGenerator.getTutorials().get(1);
		User client = MockUserGenerator.getUser();
		
		
		Mockito.when(tutorialRepository.findByTutorialId(tutorial.getTutorialId())).thenReturn(tutorial);
		Mockito.when(userRepository.findByUsername(client.getUsername())).thenReturn(client);
		Mockito.when(enrollementRepository.save(Mockito.any(Enrollement.class))).thenAnswer((i) -> i.getArguments()[0]);
		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.post("/api/v1/tutorials/789/enroll")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken(client.getUsername()))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON);

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isNoContent());
    }
	
	@Test
	public void unenroll() throws Exception {
		
		Tutorial tutorial = MockTutorialGenerator.getTutorials().get(1);
		User client = MockUserGenerator.getUser();
		Enrollement enrollement = MockEnrollementGenerator.getEnrollement(tutorial, client);
		
		Mockito.when(enrollementRepository.getEnrollementFromClientAndTutorial(client, tutorial)).thenReturn(enrollement);
		Mockito.when(tutorialRepository.findByTutorialId(tutorial.getTutorialId())).thenReturn(tutorial);
		Mockito.when(userRepository.findByUsername(client.getUsername())).thenReturn(client);
		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.delete("/api/v1/tutorials/enrolled/789")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken(client.getUsername()))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON);

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isNoContent());
    }
}