package com.groupproject.softwaretu.profilerestcontrollertest;

import com.groupproject.softwaretu.security.User;

public class MockUserGenerator{
	public static User getUser(){
		User user = new User();
		user.setId(445L);
		user.setUsername("username");
		user.setFullName("fullname");
		user.setEmail("email@email.com");
		user.setPassword("password");
		user.setRole("CLIENT");
		return user;
	}
}