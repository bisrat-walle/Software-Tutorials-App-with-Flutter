# Software Tutorials - REST API - Group Project

Our project is a mobile application that allows users to 

      1. look for tutorials
      2. create tutorials and projects
      2. enroll for their favorite tutorial
      3. submit the project attached to a specific tutorial track



## User Types

In this project we have three types of users

	1. Clients
	2. Instructors
	3. Admins


## User Stories

    1. As Instructor, I want to create tutorials together with a project so that my clients can use them
    2. As Instructor, I want to edit my tutorials so that my clients can have better exprience
    3. As Instructor, I want to delete my tutorials so that my clients will not be exposed to old and inappropriate tutorials
    4. As Instructor, I want to view my tutorials as well as others so that I will see how many tutorials are avaliable
    5. As Client, I want to enroll for my favorite tutorial so that I will follow the tutorial
    6. As Client, I want to unenroll for enrolled tutorial so that I won't follow tutorials which are not interesting
    7. As Client, I want to submit project for my enrolled tutorial so that I will wrap-up the tutorial
    8. As Client, I want to edit my submitted project so that I will improve my submission
    9. As Client, I want to delete my submitted project so that I will re-submit it with another project
    10. As Admin, I want to delete inappropriate tutorial so that users can have better experience
    11. As Admin, I want to manage clients and instructors so that the system will be robust



## Business features in addition to Authentication and Authorization

    1. Tutorial Creation for Instructors - CRUD operations (CreateTutorial(POST), 
		ViewTutorial(GET),  EditTutoiral(PUT), DeleteTutorial(DELETE))
    2. Project Submission - CRUD operations (SubmitProject(POST),  ViewSubmittedProject(GET), 
    			EditSubmittedProject(PUT), DeleteSubmittedProject(DELETE))
    3. Project Creation for Instructors -  CRUD operations (CreateProject(POST), 
		ViewProject(GET),  UpdateProject (PUT), DeleteProject(DELETE))
    4. Tutorial Enrollement for Clients - CRUD operations (Enroll(POST), UnEnroll(DELETE), 
    			ViewEnrolledTutorial(GET)), REENROLL(PUT))

 
## Technologies Used
	
	
  	1. Flutter - Dart for UI
	2. Spring Boot - Java for RESTful API
	3. MySQL database as a backend

## Remark

<pre>

	1. This RESTful API has its own documentation based on swagger 2 (Open API Specification). 
	   The documentation can be accessed by going to the route "/swagger" after running the 
	   project.

	2. Since Admins cannot signup for the system, we have used CommandLine runner to create 
	   an admin with 
	   	1. Username - admin
		2. Password - admin
	   So you can use this user to explore about the admin

</pre>
      
## Group Members

           Name                 ID         	     Section
	1. Abraham Shimekt    	UGR/0129/12		1
	2. Bamlaku Hiruy      	UGR/4774/12		3
	3. Bisrat Walle       	UGR/4425/12		3
	4. Haile Dereje	      	UGR/2190/12		3
	5. Ysihak Bazezew     	UGR/1131/12		3




