class Project{
	int? projectId;
    String? title;
    String? problemStatement;
    Project({this.title, this.problemStatement, this.projectId});
	
	factory Project.fromJson(Map<String, dynamic?>? json){
		if (json == null){
			return Project();
		}
		return Project(
			projectId: json['projectId'],
			title: json['title'],
			problemStatement: json['problemStatement']
		);
	}
}

class ProjectSubmission {
    String? projectUrl;
	ProjectSubmission({this.projectUrl});
	
	factory ProjectSubmission.fromJson(Map<String, dynamic?> json){
	
	return ProjectSubmission(projectUrl: json['projectUrl']);
	}
	
}
