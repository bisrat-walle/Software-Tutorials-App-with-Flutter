# Software Tutorials - Group Project

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

    1. As Instructor, I want to create tutorials together with a project
    2. As Instructor, I want to edit my tutorials
    3. As Instructor, I want to delete my tutorials
    4. As Instructor, I want to view my tutorials as well as others
    5. As Client, I want to enroll for my favorite tutorial
    6. As Client, I want to unenroll for enrolled tutorial
    7. As Client, I want to submit project for my enrolled tutorial
    8. As Client, I want to edit my submitted tutorial
    9. As Client, I want to delete my submitted tutorial
    10. As Admin, I want to delete inappropriate tutorial
    11. As Admin, I want to manage clients and instructors



## Business features in addition to Authentication and Authorization

    1. Tutorial Creation for Instructors - CRUD operations (CreateTutorial(POST), ViewTutorial(GET), 
    			EditTutoiral(PUT), DeleteTutorial(DELETE))
    2. Project Submission - CRUD operations (SubmitProject(POST),  ViewSubmittedProject(GET), 
    			EditSubmittedProject(PUT), DeleteSubmittedProject(DELETE))
    3. Project Creation for Instructors -  CRUD operations (CreateProject(POST), ViewProject(GET), 
                        UpdateProject (PUT), DeleteProject(DELETE))
    4. Tutorial Enrollement for Clients - CRUD operations (Enroll(POST), UnEnroll(DELETE), 
    			ViewEnrolledTutorial(GET)), REENROLL(PUT))




## Security Features

| Role  	| Can do 							    |
| ------------- | ----------------------------------------------------------------- |
| Instructor    | Create Tutorial  						    |
|               | View Tutorial  						    |
|               | Update Tutorial  						    |
|               | Delete Tutorial  						    |
|										    |
| Client        | Enroll for Tutorial  						    |
|               | UnEnroll for Tutorial  					    |
|               | ReEnroll for Tutorial  					    |
|               | Submit the project for the tutorials they enrolled in  	    |
|               | View the project submited for the tutorials they enrolled in      |
|               | Update the project submited for the tutorials they enrolled in    |
|               | Delete the project submited for the tutorials they enrolled in    |
|										    |
| Admin         | Delete any Tutorial  						    |
|               | View Tutorial  						    |


 
## Technologies Used

	1. Spring Boot - Java
	2. MySQL database as a backend
  	3. Flutter - Dart


      
## Group Members

           Name                      ID                 Section
	1.
