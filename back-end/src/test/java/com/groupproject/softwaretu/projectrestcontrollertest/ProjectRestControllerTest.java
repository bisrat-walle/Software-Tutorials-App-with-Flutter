package com.groupproject.softwaretu.projectrestcontrollertest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.groupproject.softwaretu.MockAuthTokenGenerator;
import com.groupproject.softwaretu.apiv1.project.ProjectRestController;
import com.groupproject.softwaretu.apiv1.project.ProjectSubmission;
import com.groupproject.softwaretu.enrollement.Enrollement;
import com.groupproject.softwaretu.enrollement.EnrollementRepository;
import com.groupproject.softwaretu.enrollement.EnrollementService;
import com.groupproject.softwaretu.enrollementrestcontrollertest.MockEnrollementGenerator;
import com.groupproject.softwaretu.profilerestcontrollertest.MockUserGenerator;
import com.groupproject.softwaretu.project.ProjectRepository;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.security.UserRepository;
import com.groupproject.softwaretu.security.UserService;
import com.groupproject.softwaretu.tutorial.Tutorial;
import com.groupproject.softwaretu.tutorial.TutorialRepository;
import com.groupproject.softwaretu.tutorial.TutorialService;
import com.groupproject.softwaretu.tutorialrestcontrollertest.MockTutorialGenerator;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.springframework.security.crypto.password.PasswordEncoder;

@WebMvcTest(ProjectRestController.class)
public class ProjectRestControllerTest {
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
	
	@MockBean
	PasswordEncoder passwordEncoder;
	
	@Test
	public void submitProject() throws Exception {
		
		Tutorial tutorial = MockTutorialGenerator.getTutorials().get(1);
		User client = MockUserGenerator.getUser();
		Enrollement enrollement = MockEnrollementGenerator.getEnrollement(tutorial, client);
		ProjectSubmission sub = MockProjectSubmissionGenerator.get("https://github.com");

		Mockito.when(userService.getAuthenticatedUser()).thenReturn(client);
		Mockito.when(tutorialRepository.findByTutorialId(tutorial.getTutorialId())).thenReturn(tutorial);
		Mockito.when(userRepository.findByUsername(client.getUsername())).thenReturn(client);
		Mockito.when(enrollementRepository.getEnrollementFromClientAndTutorial(client, tutorial)).thenReturn(enrollement);
		Mockito.when(enrollementRepository.save(Mockito.any(Enrollement.class))).thenAnswer((i) -> i.getArguments()[0]);
		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.post("/api/v1/tutorials/789/project")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken(client.getUsername()))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.content(this.mapper.writeValueAsString(sub));

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isNoContent());
    }
	
	@Test
	public void editProject() throws Exception {
		
		Tutorial tutorial = MockTutorialGenerator.getTutorials().get(1);
		User client = MockUserGenerator.getUser();
		Enrollement enrollement = MockEnrollementGenerator.getEnrollement(tutorial, client);
		ProjectSubmission sub = MockProjectSubmissionGenerator.get("https://github.com");

		Mockito.when(userService.getAuthenticatedUser()).thenReturn(client);
		Mockito.when(tutorialRepository.findByTutorialId(tutorial.getTutorialId())).thenReturn(tutorial);
		Mockito.when(userRepository.findByUsername(client.getUsername())).thenReturn(client);
		Mockito.when(enrollementRepository.getEnrollementFromClientAndTutorial(client, tutorial)).thenReturn(enrollement);
		Mockito.when(enrollementRepository.save(Mockito.any(Enrollement.class))).thenAnswer((i) -> i.getArguments()[0]);
		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put("/api/v1/tutorials/789/project")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken(client.getUsername()))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.content(this.mapper.writeValueAsString(sub));

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isNoContent());
    }
	
	@Test
	public void deleteProject() throws Exception {
		
		Tutorial tutorial = MockTutorialGenerator.getTutorials().get(1);
		User client = MockUserGenerator.getUser();
		Enrollement enrollement = MockEnrollementGenerator.getEnrollement(tutorial, client);


		Mockito.when(userService.getAuthenticatedUser()).thenReturn(client);
		Mockito.when(tutorialRepository.findByTutorialId(tutorial.getTutorialId())).thenReturn(tutorial);
		Mockito.when(userRepository.findByUsername(client.getUsername())).thenReturn(client);
		Mockito.when(enrollementRepository.getEnrollementFromClientAndTutorial(client, tutorial)).thenReturn(enrollement);
		Mockito.when(enrollementRepository.save(Mockito.any(Enrollement.class))).thenAnswer((i) -> i.getArguments()[0]);
		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.delete("/api/v1/tutorials/789/project")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken(client.getUsername()))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON);

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isNoContent());
    }
}