package com.groupproject.softwaretu.tutorialrestcontrollertest;

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
import com.groupproject.softwaretu.apiv1.tutorial.TutorialRestController;
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
import com.groupproject.softwaretu.project.ProjectRepository;
import com.groupproject.softwaretu.tutorial.TutorialService;
import com.groupproject.softwaretu.security.UserService;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

@WebMvcTest(TutorialRestController.class)
public class TutorialRestControllerTest {
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
	public void getAllTutorials() throws Exception {
		List<Tutorial> tutorials = MockTutorialGenerator.getTutorials();
		Mockito.when(tutorialRepository.findAll()).thenReturn(tutorials);
		
		mockMvc.perform(MockMvcRequestBuilders
				.get("/api/v1/tutorials/all")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken("admin"))
				.contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().isOk())
				.andExpect(jsonPath("$", hasSize(3)))
				.andExpect(jsonPath("$[1].title", is("Tutorial 2")));
	}
	
	@Test
	public void getTutorial() throws Exception {
		List<Tutorial> tutorials = MockTutorialGenerator.getTutorials();
		Tutorial tutorial1 = tutorials.get(0);
		
		Mockito.when(tutorialRepository.findByTutorialId(tutorial1.getTutorialId())).thenReturn(tutorial1);

		mockMvc.perform(MockMvcRequestBuilders
				.get("/api/v1/tutorials/53409")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken("admin"))
				.contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().isOk());
	}
	
	@Test
	public void createTutorial() throws Exception {
		
		Tutorial tutorial = new Tutorial();
		tutorial.setTitle("Tutorial");
		tutorial.setContent("Some content");
		tutorial.setProject(new Project(8089L, "New York USA", "fsjlkdklj"));

		Mockito.when(tutorialRepository.save(tutorial)).thenReturn(tutorial);

		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.post("/api/v1/tutorials/")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken("admin"))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.content(this.mapper.writeValueAsString(tutorial));

		mockMvc.perform(mockRequest)
				.andDo(MockMvcResultHandlers.print())
				.andExpect(status().isCreated());
    }
	
	@Test
	public void updateTutorial() throws Exception {
		Tutorial tutorial = new Tutorial();
		tutorial.setTutorialId(789L);
		tutorial.setTitle("Tutorial 3");
		tutorial.setContent("fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj");
		tutorial.setProject(new Project(78987L, "kdjffls", "fjsdlj"));
		
		Tutorial updatedTutorial = new Tutorial();
		updatedTutorial.setTitle("Updated Tutorial");
		updatedTutorial.setContent("Some content for testing update tutorial");
		updatedTutorial.setProject(new Project(8089L, "New York USA", "fsjlkdklj"));

		Mockito.when(tutorialRepository.findByTutorialId(tutorial.getTutorialId())).thenReturn(tutorial);
		Mockito.when(tutorialRepository.save(updatedTutorial)).thenReturn(updatedTutorial);

		MockHttpServletRequestBuilder mockRequest = MockMvcRequestBuilders.put("/api/v1/tutorials/789")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken("admin"))
				.contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.content(this.mapper.writeValueAsString(updatedTutorial));

		mockMvc.perform(mockRequest)
				.andExpect(status().isOk());
	}
	@Test
	public void deleteTutorialByTutorialId() throws Exception {
		Tutorial tutorial2 = new Tutorial();
		tutorial2.setTutorialId(789L);
		tutorial2.setTitle("Tutorial 2");
		tutorial2.setContent("fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj fdskjlfdsjkkjlfdj");
		tutorial2.setProject(new Project(980L, "kdjffls", "fjsdlj"));
		
		Mockito.when(tutorialRepository.findByTutorialId(tutorial2.getTutorialId())).thenReturn(tutorial2);

		mockMvc.perform(MockMvcRequestBuilders
				.delete("/api/v1/tutorials/789")
				.accept(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer "+MockAuthTokenGenerator.getToken("admin"))
				.contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().isNoContent());
	}
}