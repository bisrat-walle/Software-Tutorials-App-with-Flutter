import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softwaretutorials/infrastructure/repositories/tutorial_service.dart';
import 'package:softwaretutorials/presentation/core/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/presentation/pages/screens/manage_users_screen.dart';
import 'package:softwaretutorials/presentation/pages/screens/screens.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';
import '../../components/components.dart';

class TutorialScreen extends StatelessWidget {
  TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs =
        BlocProvider.of<AuthenticationBloc>(context).preferences;
    final _navigatorBloc = BlocProvider.of<NavigationBloc>(context);
    final username = prefs.get("username");
    final _tutorialBloc = TutorialBloc();
    _tutorialBloc.add(LoadAllTutorials(0));
    final role = prefs.get("role");
    return BlocProvider<TutorialBloc>(
        create: (context) => _tutorialBloc,
        child: Scaffold(
          drawer: CustomDrawer.get(context),
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<TutorialBloc, TutorialState>(
              builder: (context, state) {
                if (state is TutorialDetailState) {
                  return Text(state.tutorial.title!);
                }

                if (state is CreateTutorialState) {
                  return Text("Create Tutorial");
                }
                if (state is UpdateTutorialState)
                  return Text("Update Tutorial");
                if (state is EnrolledTutorialsLoaded)
                  return Text("Enrolled Tutorials");
                if (state is MyTutorialsLoadedState)
                  return Text("My Tutorials");
                if (role == "ADMIN")
                return Text("Manage Users and Tutorials");
                return Text("All Tutorials");
              },
            ),
            actions: [
              BlocBuilder<TutorialBloc, TutorialState>(
                builder: (context, state) {
                  if (state is TutorialDetailState) {
                    	if (username == state.tutorial.instructor!.username)
                      Row(
                        children: [
                          IconButton(onPressed: () async {}, icon: Icon(Icons.edit, color: Colors.black,)),
                          SizedBox(width: 10,),
                          IconButton(onPressed: () async {

                            final res = await TutorialRepository.deleteTutorial(tutorialId: state.tutorial.tutorialId!);
                            print(res);
                          }

                            ,icon: Icon(Icons.delete, color: Colors.red,),),
                          SizedBox(width: 20,)
                        ],
                      );
                  }
                  if (state is CreateTutorialState) {
                    return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: IconButton(
                            icon: Icon(Icons.check, size: 25),
                            onPressed: () async {

                              if (state.tutorialForm.formKey.currentState!.validate()){
                                _tutorialBloc.add(CreateTutorialEvent(state.tutorialForm, state.selectedTab));
                              }

                            }));
                  }
                  if (state is UpdateTutorialState) {
                    return Container(
                        margin: EdgeInsets.only(right: 10),
                        child: IconButton(
                            icon: Icon(Icons.check, size: 25),
                            onPressed: () async {

                              if (state.tutorialForm.formKey.currentState!.validate()){
                                _tutorialBloc.add(UpdateTutorialEvent(state.tutorialForm, state.selectedTab));
                              }

                            }));
                  }
                  return Container();
                },
              ),
            ],
          ),
          // drawer: SafeArea(child: CustomDrawer.get(context)),
          body: BlocConsumer<TutorialBloc, TutorialState>(
            listener: (context, state) {
              if (state is EnrolledTutorialsLoaded)
                _navigatorBloc.add(GotoEnrolledTutorials());
              if (state is MyTutorialsPage)
                _navigatorBloc.add(GotoMyTutorials());
            },
            builder: (context, state) {
            if (state is! ManageUser) {
              if (state is ManageUsersScreen) {
                return ManageUsersScreen();
              }

              if(state is TutorialDetailState){
                return TutorialDetailScreen(tutorial: state.tutorial);
              }


              if (state is CreateTutorialState) {
                return CreateTutorialScreen(state.tutorialForm);
              }
              if (state is UpdateTutorialState) {
                return CreateTutorialScreen(state.tutorialForm);
              }
              
              return TutorialListView();
              } else {
                return ManageUsersScreen();
              }
            },
          ),
          bottomNavigationBar: BlocBuilder<TutorialBloc, TutorialState>(
            builder: (context, state) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: state.selectedTab,
                onTap: (index) {
                  if (state.selectedTab == 1 && role == "ADMIN"){
                    _tutorialBloc.add(GotoManageUserEvent(index));
                  }

                  if (index == 1 && role == "ADMIN"){
                    _tutorialBloc.add(GotoManageUserEvent(index));
                  }
                  if (index == 0){
                    _tutorialBloc.add(LoadAllTutorials(index));
                  }
                  if(index == 1){
                    if (role == "INSTRUCTOR")
                    _tutorialBloc.add(LoadMyTutorials(index));
                    if(role == "CLIENT")
                    _tutorialBloc.add(LoadEnrolledTutorials(index));
                  }
                  if (index == 2 && state is! UpdateTutorialState){
                    _tutorialBloc.add(GotoCreateTutorialEvent(index));
                  }
                },
                items: <BottomNavigationBarItem>[
                  if (role != "ADMIN")
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.collections),
                    label: 'All Tutorials',
                  ),
                  if (role == "ADMIN")
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.collections),
                    label: 'Manage Tutorials',
                  ),
                  // const BottomNavigationBarItem(
                  //   icon: Icon(Icons.search),
                  //   label: 'Search tutorial',
                  // ),
                  if (role == "INSTRUCTOR")
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: "My Tutorials",
                    ),
                  if (role == "CLIENT")
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: 'Enrolled Tutorials',
                    ),
                  if (role == "INSTRUCTOR" && state is! UpdateTutorialState)
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      label: 'Create Tutorial',
                    ),
                  if (role == "INSTRUCTOR" && state is UpdateTutorialState)
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.edit),
                      label: 'Update Tutorial',
                    ),
                  if (role == "ADMIN")
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.manage_accounts),
                      label: 'Manage Users',
                    ),
                ],
              );
            },
          ),
        ));
  }
}
