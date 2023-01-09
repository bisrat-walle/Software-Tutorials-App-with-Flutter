import 'package:equatable/equatable.dart';

class Project extends Equatable {
  int? projectId;
  String? title;
  String? problemStatement;
  Project({this.title, this.problemStatement, this.projectId});

  factory Project.fromJson(Map<String, dynamic?>? json) {
    if (json == null) {
      return Project();
    }
    return Project(
        projectId: json['projectId'],
        title: json['title'],
        problemStatement: json['problemStatement']);
  }

  Map<String, dynamic> toJson() => {
        "projectId": this.projectId,
        "title": this.title,
        "problemStatement": this.problemStatement
      };

  @override
  List<Object?> get props => [projectId];
}

class ProjectSubmission {
  String? projectUrl;
  ProjectSubmission({this.projectUrl});

  factory ProjectSubmission.fromJson(Map<String, dynamic?> json) {
    return ProjectSubmission(projectUrl: json['projectUrl']);
  }
}
