import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/domain/models/models.dart';
import 'package:softwaretutorials/domain/models/tutorial_form_model.dart';
import 'package:softwaretutorials/infrastructure/repositories/enrollement_service.dart';
import 'package:softwaretutorials/infrastructure/repositories/tutorial_service.dart';
import 'package:softwaretutorials/presentation/core/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/presentation/pages/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';

class TutorialCard extends StatelessWidget {
  
  late String role;
  late bool isInstructor;
  late bool isAdmin;
  late bool isClient;
  late String username;
  late SharedPreferences prefs;
  late final Tutorial tutorial;
  TutorialCard({Key? key,required Tutorial tutorial}) {
    this.tutorial = tutorial;
  }

  @override
  Widget build(BuildContext context) {
	final SharedPreferences prefs = BlocProvider.of<AuthenticationBloc>(context).preferences;
  final TutorialBloc tutorialBloc = BlocProvider.of<TutorialBloc>(context);
	role = prefs.get("role").toString();
	isInstructor = role == "INSTRUCTOR";
    isAdmin = role == "ADMIN";
    isClient = role == "CLIENT";
    username = prefs.getString("username")!;
    return  Center(
              child: GestureDetector(
                onTap: (){},
                child: InkWell(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.black.withOpacity(.1)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      constraints: BoxConstraints(maxWidth:450),
                      height: 200,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            SizedBox(height:25),
                            Expanded(
                              child:Container(
                                margin: EdgeInsets.only(left:25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget> [
                                    Container(child: Text(tutorial.title!, textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline2),),
                                    Container(child: Text("Instructor: "+tutorial.instructor!.fullName!.toString(),
                                        style: Theme.of(context).textTheme.headline3),
                                      decoration: BoxDecoration(
                                        border: Border(bottom:BorderSide(
                                            width: 1,color:Colors.black.withOpacity(.1))),
                                      ),

                                      width: 300,

                                    ),
                                    SizedBox(height: 20),
                                    Text(tutorial.content!.substring(0, 20)+" ... "),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border(top:BorderSide(
                                      width: 1,color:Colors.black.withOpacity(.1))),
                                ),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget> [
                                    Container(
                                        padding: EdgeInsets.only(left: 25),
                                        child: Text("${tutorial.enrollementCount!} Clients Enrolled", )
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget> [
                                        if (tutorial.enrolled!) ElevatedButton(
                                          child: FittedBox(child:Text("Unenroll"),),
                                          onPressed: () async {
                                            final res = await EnrollementService.unenroll(tutorialId: tutorial.tutorialId!);
                                            print(res);
                                          },

                                          style: ElevatedButton.styleFrom(
                                            textStyle: TextStyle(color: Colors.white),
                                            padding: EdgeInsets.all(8),
                                            splashFactory: InkSplash.splashFactory,
                                            primary: Colors.blue

                                          ),
                                        ),
                                        if (isClient && !tutorial.enrolled!) ElevatedButton(
                                          child: FittedBox(child:Text("Enroll"),),
                                          onPressed: () async {
                                            final res = await EnrollementService.enroll(tutorialId: tutorial.tutorialId!);
                                            print(res);
                                          },

                                          style: ElevatedButton.styleFrom(
                                              textStyle: TextStyle(color: Colors.white),
                                              padding: EdgeInsets.all(8),
                                              splashFactory: InkSplash.splashFactory,
                                              primary: Colors.blue

                                          ),
                                        ),
                                        SizedBox(width:20),


                                        if (isAdmin|| tutorial.enrolled! || tutorial.instructor!.username! == username) ElevatedButton(
                                          child: FittedBox(child:Text("Explore"),),
                                          onPressed: () {
                                            tutorialBloc.add(GotoTutorialDetailEvent(tutorial, 0));
                                          },

                                          style: ElevatedButton.styleFrom(
                                              textStyle: TextStyle(color: Colors.white),
                                              padding: EdgeInsets.all(8),
                                              splashFactory: InkSplash.splashFactory,
                                              primary: Colors.blue

                                          ),
                                        ),
                                        SizedBox(width:20),
                                        if (tutorial.instructor!.username! == username || role == "ADMIN")
                                          Row(
                                            children: [
											
											if (tutorial.instructor!.username! == username)
                                              ElevatedButton(
                                                child: FittedBox(child:Text("Edit"),),
                                                onPressed: () {
                                                  tutorialBloc.add(GotoUpdateTutorialEvent(TutorialFormModel.fromTutorial(tutorial), 3));
                                                },

                                                style: ElevatedButton.styleFrom(
                                                    textStyle: TextStyle(color: Colors.white),
                                                    padding: EdgeInsets.all(8),
                                                    splashFactory: InkSplash.splashFactory,
                                                    primary: Colors.blue

                                                ),
                                              ),
                                              IconButton(onPressed: () async {

                                                final res = await TutorialRepository.deleteTutorial(tutorialId: tutorial.tutorialId!);
                                                print(res);
                                              }

                                                ,icon: Icon(Icons.delete, color: Colors.red,),)
                                            ],
                                          ),
                                        SizedBox(height:50),
                                      ],
                                    )
                                  ],
                                )
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              )
          );
  }
}