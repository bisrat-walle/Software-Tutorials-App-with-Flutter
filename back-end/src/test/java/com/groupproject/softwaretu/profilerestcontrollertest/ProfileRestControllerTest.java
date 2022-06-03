package com.groupproject.softwaretu.profilerestcontrollertest;

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
import com.groupproject.softwaretu.enrollementrestcontrollertest.MockEnrollementGenerator;
import com.groupproject.softwaretu.projectrestcontrollertest.MockProjectSubmissionGenerator;
import com.groupproject.softwaretu.security.User;
import com.groupproject.softwaretu.apiv1.profile.ProfileRestController;
import com.groupproject.softwaretu.MockAuthTokenGenerator;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;


@WebMvcTest(ProfileRestController.class)
public class ProfileRestControllerTest {
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
    UserDetailsService userDetailsService;
    
    @MockBean
    PasswordEncoder bCryptPasswordEncoder;
	
	@Test
	public void register() throws Exception {
		
		Tutorial tutorial = MockTutorialGenerator.getTutorials().get(1);
		User client = MockUserGenerator.getUser();
		client.setId(null);
		
		
		Mockito.when(userRepository.save(Mockito.any(User.class))).thenAnswer((i) -> i.getArguments()[0]);
		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.post("/api/v1/register")
				.accept(MediaType.APPLICATION_JSON)
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.content(this.mapper.writeValueAsString(client));

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isCreated());
    }
	
	@Test
	public void updateProfile() throws Exception {
		
		User client = MockUserGenerator.getUser();
		User updatedUser = MockUserGenerator.getUser();
		updatedUser.setFullName("Hello World");
		
		Mockito.when(userRepository.findByUsername(client.getUsername())).thenReturn(client);
		Mockito.when(userRepository.save(updatedUser)).thenReturn(updatedUser);
		Mockito.when(userService.getAuthenticatedUser()).thenReturn(client);
		
		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put("/api/v1/profile")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken(client.getUsername()))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.content(this.mapper.writeValueAsString(updatedUser));

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isOk());
    }
}