import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/infrastructure/repositories/project_service.dart';
import 'package:softwaretutorials/infrastructure/repositories/tutorial_service.dart';
import 'package:softwaretutorials/presentation/core/authentication/bloc/authentication_bloc.dart';

class TutorialDetailScreen extends StatefulWidget {
  final tutorial;
  final _formKey = GlobalKey<FormState>();
 
  
  TutorialDetailScreen({Key? key, required this.tutorial}) : super(key: key);

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  late final _projectLinkController;
  late bool _fieldDisabled;
  late SharedPreferences? prefs;
  late bool? isClient;
  late String? username;
  @override
  void initState() {
    _projectLinkController = TextEditingController();
    if (widget.tutorial.submittedLink != null)
      _projectLinkController.text = widget.tutorial.submittedLink;
    _fieldDisabled = widget.tutorial.submittedLink != null;
    super.initState();
  }

  @override
  void dispose() {
    _projectLinkController.dispose();
    super.dispose();
  }

  Widget getButtons() {
    if (_fieldDisabled == true) {
      return Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  _fieldDisabled = false;
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.blue,
              )),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                ProjectService.deleteProject(
                    tutorialId: widget.tutorial!.tutorialId);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      );
    }
    return ElevatedButton(
      child: FittedBox(
        child: Text("Update"),
      ),
      onPressed: () async {
        if (widget._formKey.currentState!.validate()) {
          final res = await ProjectService.updateProject(
              tutorialId: widget.tutorial.tutorialId,
              projectUrl: _projectLinkController.text);
          print(res);
        }
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          splashFactory: InkSplash.splashFactory),
    );
  }

  @override
  Widget build(BuildContext context) {
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
		  //   controller: controller,
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
		  child: Text("Enjoy your tutorial!",
		  style: Theme.of(context).textTheme.headline2)),
		  Text(widget.tutorial.content),
		  ],
		  ),
		  ),
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
		  width: double.infinity,
		  margin: EdgeInsets.only(bottom: 10),
		  child: Text(widget.tutorial.project.title,
		  style: Theme.of(context).textTheme.headline2),
		  decoration: BoxDecoration(
		  border: Border(
		  bottom: BorderSide(
		  width: 1,
		  color: Colors.black.withOpacity(.1))),
		  ),
		  ),
		  Text(widget.tutorial.project.problemStatement),
		  SizedBox(height: 20),

		  if (isClient!)
		  Container(
		  width: double.infinity,
		  child: Text(
		  "Enter github link to submit the project",
		  style: Theme.of(context).textTheme.headline3),
		  decoration: BoxDecoration(
		  border: Border(
		  bottom: BorderSide(
		  width: 1,
		  color: Colors.black.withOpacity(.1))),
		  ),
		  ),
		  if (isClient!)
		  Row(
		  children: <Widget>[
		  Expanded(
		  child: Form(
		  key: widget._formKey,
		  child: TextFormField(
		  readOnly: _fieldDisabled,
		  controller: _projectLinkController,
		  validator: (value) {
		  if (value!.isEmpty ||
		  value == null ||
		  !RegExp(r"^https:\/\/github.com\/[A-Za-z][A-Za-z0-9]+\/[A-Za-z][A-Za-z0-9]+$")
		  		.hasMatch(value)) {
		  return "Please enter a valid github repo link";
		  }
		  },
		  cursorColor: Colors.black,
		  decoration: InputDecoration(
		  hintText:
		  'E.g https://github.com/username/reponame',
		  enabledBorder: const UnderlineInputBorder(
		  borderSide:
		  BorderSide(color: Colors.blue),
		  ),
		  focusedBorder: UnderlineInputBorder(
		  borderSide:
		  BorderSide(color: Colors.green),
		  ),
		  border: UnderlineInputBorder(
		  borderSide:
		  BorderSide(color: Colors.blue),
		  ),
		  isDense: false,
		  contentPadding: EdgeInsets.only(
		  left: 5, top: 0, bottom: 0, right: 0),
		  ),
		  ),
		  ),
		  ),
		  Container(
		  child: widget.tutorial.submittedLink == null
		  ? ElevatedButton(
		  child: FittedBox(
		  child: Text("submit"),
		  ),
		  onPressed: () async {
		  if (widget._formKey.currentState!
		  		.validate()) {
		  final res = await ProjectService
		  		.createProject(
		  tutorialId: widget
		  		.tutorial.tutorialId,
		  projectUrl:
		  _projectLinkController
		  		.text);
		  print(res);
		  }
		  },
		  style: ElevatedButton.styleFrom(
		  primary: Colors.blue,
		  textStyle: TextStyle(
		  color: Colors.white),
		  splashFactory:
		  InkSplash.splashFactory),
		  )
		  		: getButtons()),
		  ],
		  ),
		  SizedBox(height: 10),
		  ])),
				SizedBox(height: 20),
		  ],
		  ),
		  ),
		  ));
  }
}
