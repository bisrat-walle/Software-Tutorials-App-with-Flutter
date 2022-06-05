import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../core/models.dart';

class Tutorial extends Equatable{
    int? tutorialId;
    String? title;
    String? content;
	bool? enrolled;
    String? submittedLink;
	User? instructor;
	int? enrollementCount;
	Project? project;
    Tutorial({this.enrollementCount, this.tutorialId, this.content, this.title, this.enrolled,
				this.submittedLink, this.instructor, this.project});

    @override
		String toString(){
    	return "Tutorial {title: $title}";
		}
	factory Tutorial.fromJson(Map<String, dynamic?>? json) {
		if (json == null){
			return Tutorial();
		}
    print(json.toString());
		return Tutorial(
		  tutorialId: json['tutorialId'],
		  title: json['title'],
		  enrolled: json['enrolled'],
		  content: json['content'],
		  submittedLink: json['submittedLink'],
		  instructor: User.fromJson(json['instructor']),
		  project: Project.fromJson(json['project']),
			enrollementCount: json['enrollementCount']
		);
    }
  
  Map<String, dynamic> toJson() => {
        "tutorialId": this.tutorialId,
        "title": this.title,
        "content": this.content,
        "submittedLink": this.submittedLink,
        "enrolled": this.enrolled! ? 1:0,
        "enrollementCount": this.enrollementCount,
        "instructor": jsonEncode(this.instructor!.toJson()),
        "project": jsonEncode(this.project!.toJson())
      };
  Map<String, dynamic> toMockJson() => {
        "tutorialId": this.tutorialId,
        "title": this.title,
        "content": this.content,
        "submittedLink": this.submittedLink,
        "enrolled": this.enrolled!,
        "enrollementCount": this.enrollementCount,
        "instructor": this.instructor!.toJson(),
        "project": this.project!.toJson()
      };
factory Tutorial.fromSqliteJson(Map<String, dynamic?>? json) {
		if (json == null){
			return Tutorial();
		}
		return Tutorial(
		  tutorialId: json['tutorialId'],
		  title: json['title'],
		  enrolled: json['enrolled'] == 1,
		  content: json['content'],
		  submittedLink: json['submittedLink'],
		  instructor: User.fromJson(jsonDecode(json['instructor'])),
		  project: Project.fromJson(jsonDecode(json['project'])),
			enrollementCount: json['enrollementCount']
		);
    }

  @override
  List<Object?> get props => [tutorialId];
	
}
