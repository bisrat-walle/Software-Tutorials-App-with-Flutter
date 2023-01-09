import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/domain/tutorials/project_form_model.dart';
import 'package:softwaretutorials/presentation/pages/components/custom_snack_bar.dart';
import 'package:softwaretutorials/presentation/pages/screens/project_submission/bloc/project_bloc.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';

class TutorialDetailScreen extends StatefulWidget {
  TutorialDetailScreen({Key? key}) : super(key: key);

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  late ProjectFormModel _projectForm;
  late SharedPreferences? prefs;
  late bool? isClient;
  late String? username;
  late ProjectBloc projectBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _projectForm.dispose();
    super.dispose();
  }

  Widget getButtons() {
    return Row(
      children: [
        ElevatedButton(
          child: const FittedBox(
            child: Text("Update"),
          ),
          onPressed: () async {
            if (_projectForm.formKey.currentState!.validate()) {
              projectBloc.add(ProjectUpdate(_projectForm.tutorial.tutorialId!,
                  _projectForm.projectLinkController.text));
            }
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              textStyle: TextStyle(color: Colors.white),
              splashFactory: InkSplash.splashFactory),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: () {
              projectBloc.add(ProjectDelete(_projectForm.tutorial.tutorialId!));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    projectBloc = BlocProvider.of<ProjectBloc>(context);
    final tutorialBloc = BlocProvider.of<TutorialBloc>(context);
    return BlocConsumer<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state.message != "") {
          CustomSnackBar.display(context, CustomSnackBar.get(state.message));
        }
      },
      builder: (context, state) {
        if (state is TutorialFetching || projectBloc.state.tutorial == null)
          return Center(child: CircularProgressIndicator());
        final tutorial = projectBloc.state.tutorial!;
        if (tutorial.submittedLink == null) {
          _projectForm = ProjectFormModel.fromTutorial(tutorial);
        } else {
          _projectForm = ProjectFormModel.fromTutorial(tutorial);
        }
        // _fieldDisabled = tutorial.submittedLink != null;
        prefs = BlocProvider.of<AuthenticationBloc>(context).preferences;
        isClient = prefs!.get("role").toString() == "CLIENT";
        username = prefs!.getString("username");
        return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(.1)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              constraints: BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(.1)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Colors.black.withOpacity(.1))),
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Text("Enjoy your tutorial!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                  if (prefs!.get("role") == "CLIENT")
                                    Text(
                                      "Scroll down to the bottom to see and submit, edit, update or delete project",
                                      textAlign: TextAlign.center,
                                    )
                                ],
                              )),
                          Text(projectBloc.state.tutorial!.content!),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(.1)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                    projectBloc.state.tutorial!.project!.title!,
                                    style:
                                        Theme.of(context).textTheme.headline2),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Colors.black.withOpacity(.1))),
                                ),
                              ),
                              Text(projectBloc
                                  .state.tutorial!.project!.problemStatement!),
                              SizedBox(height: 20),
                              if (isClient!)
                                Container(
                                    child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                          "Enter github link to submit the project",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.black
                                                    .withOpacity(.1))),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Form(
                                            key: _projectForm.formKey,
                                            child: TextFormField(
                                              controller: _projectForm
                                                  .projectLinkController,
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value == null ||
                                                    !RegExp(r"^https:\/\/github.com\/[A-Za-z][A-Za-z0-9]+\/[A-Za-z][A-Za-z0-9]+$")
                                                        .hasMatch(value)) {
                                                  return "Please enter a valid github repo link";
                                                }
                                              },
                                              cursorColor: Colors.black,
                                              decoration: const InputDecoration(
                                                hintText:
                                                    'E.g https://github.com/us/re',
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.green),
                                                ),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                isDense: false,
                                                contentPadding: EdgeInsets.only(
                                                    left: 5,
                                                    top: 0,
                                                    bottom: 0,
                                                    right: 0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: tutorial.submittedLink ==
                                                    null
                                                ? ElevatedButton(
                                                    child: FittedBox(
                                                      child: state
                                                              is ProjectSubmissionLoading
                                                          ? const Text(
                                                              "submitting ... ")
                                                          : Text("submit"),
                                                    ),
                                                    onPressed: () async {
                                                      if (_projectForm
                                                          .formKey.currentState!
                                                          .validate()) {
                                                        projectBloc.add(
                                                            ProjectCreation(
                                                                tutorial
                                                                    .tutorialId!,
                                                                _projectForm
                                                                    .projectLinkController
                                                                    .text));
                                                        tutorialBloc.add(
                                                            GotoTutorialDetailEvent(
                                                                tutorial,
                                                                tutorialBloc
                                                                    .state
                                                                    .selectedTab));
                                                      }
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.blue,
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        splashFactory: InkSplash
                                                            .splashFactory),
                                                  )
                                                : getButtons()),
                                      ],
                                    ),
                                  ],
                                )),
                              const SizedBox(height: 10),
                            ])),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
