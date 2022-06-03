import 'package:flutter/material.dart';
import 'package:softwaretutorials/domain/core/models.dart';

class TutorialFormModel {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final TextEditingController projectTitleController;
  final TextEditingController problemStatementController;
  final formKey;
  late int? tutorialId;

  TutorialFormModel(this.titleController, this.contentController, this.projectTitleController, this.problemStatementController, this.formKey, {this.tutorialId});

  factory TutorialFormModel.fromTutorial(Tutorial tutorial){
    return TutorialFormModel(
      TextEditingController(text: tutorial.title), 
      TextEditingController(text: tutorial.content), 
      TextEditingController(text: tutorial.project!.title!), 
      TextEditingController(text: tutorial.project!.problemStatement),
      GlobalKey<FormState>(),
      tutorialId: tutorial.tutorialId);
  }

  factory TutorialFormModel.empty(){
    return TutorialFormModel(
      TextEditingController(), 
      TextEditingController(), 
      TextEditingController(), 
      TextEditingController(),
      GlobalKey<FormState>());
  }

  void dispose(){
    this.titleController.dispose();
    this.contentController.dispose();
    this.projectTitleController.dispose();
    this.problemStatementController.dispose();
  }
}