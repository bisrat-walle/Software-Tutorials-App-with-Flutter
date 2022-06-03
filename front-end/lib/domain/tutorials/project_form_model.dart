import 'package:flutter/material.dart';
import 'package:softwaretutorials/domain/core/models.dart';

class ProjectFormModel {
  final TextEditingController projectLinkController;
  final GlobalKey<FormState> formKey;
  late Tutorial tutorial;

  ProjectFormModel(this.formKey, this.tutorial, this.projectLinkController);

  factory ProjectFormModel.fromTutorial(Tutorial tutorial){
    if (tutorial.submittedLink == null) {
      return ProjectFormModel(
      GlobalKey<FormState>(),
      tutorial,
      TextEditingController());
    }
    return ProjectFormModel(
      GlobalKey<FormState>(),
      tutorial,
      TextEditingController(text: tutorial.submittedLink!));
  }

  void dispose(){
    projectLinkController.dispose();
  }
}