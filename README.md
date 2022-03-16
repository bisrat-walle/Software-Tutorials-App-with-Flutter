# Software Tutorials - Group Project
<pre>
Our project is a mobile application that allows users to 
      1. look for tutorials
      2. create tutorials and projects
      2. enroll for their favorite tutorial
      3. submit the project attached to a specific tutorial track
</pre>


## User Types

<pre>
In this project we have three types of users
	1. Clients
	2. Instructors
	3. Admins
</pre>

## User Stories


## Business features in addition to authentication and authorization

<pre>
    1. Tutorial Enrollement for Clients - CRUD operations (Enroll(POST), UnEnroll(DELETE), ViewTutorial(GET)), REENROLL(PUT)
    2. Tutorial Creation for Instructors - CRUD operations (Create(POST), ViewTutorial(GET))
    3. Project Submission - CRUD operations (SubmitProject(POST),  ViewProject(GET))
    4. Project Creation for Instructors -  CRUD operations (CreateProject(POST), ViewProject(GET), 
                        UpdateProject (PUT), DeleteProject(DELETE))
</pre>
      
## Group Members

<pre>
           Name                      ID                 Section

</pre>


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

<pre>
	1. Spring Boot - Java
	2. MySQL database as a backend
  	3. Flutter - Dart
</pre>


