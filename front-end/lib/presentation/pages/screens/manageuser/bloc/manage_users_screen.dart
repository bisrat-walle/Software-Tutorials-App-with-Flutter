// ignore_for_file: curly_braces_in_flow_control_structures

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';
import 'package:softwaretutorials/presentation/pages/screens/manageuser/bloc/manageuser_bloc.dart';
import 'package:softwaretutorials/presentation/pages/screens/tutorial/bloc/tutorial_bloc.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

class ManageUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _manageUserBloc = ManageuserBloc(RepositoryProvider.of<ProfileRepository>(context), BlocProvider.of<TutorialBloc>(context));
    final username = BlocProvider.of<AuthenticationBloc>(context).preferences.get("username");
    _manageUserBloc.add(GotoManageUserScreenEvent());
    return BlocBuilder<ManageuserBloc, ManageuserState>(
                            bloc: _manageUserBloc,
                            builder: (context, state) {
                              if (state is ManageUserLoading)
                                return Center(child: CircularProgressIndicator(),);
                              if (state is ManageuserState) {
                                return Container(
      color: Color(0xff471F7A),
      child: Center(
          child: Container(
              padding:EdgeInsets.all(10.0),
              constraints: BoxConstraints(maxWidth: 500),
              child: Container(
                child: ListView.builder(
                    itemCount: state.userList.length+1,
                    itemBuilder: (BuildContext context,int index){
                      if (index == 0){
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.cyan,
                          height: 50,
                          child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Username",), Text("Action", style: TextStyle(fontSize: 20),)],
                          ),
                        );
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color:index %2 == 0 ? Colors.white.withOpacity(.5) : Colors.white ,
                        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(state.userList[index-1].username!),TextButton(child: Icon(Icons.delete, color: username == state.userList[index-1].username! ? Colors.grey : Colors.red,
                        ),onPressed: username == state.userList[index-1].username! ? null : (){
                          _manageUserBloc.add(DeleteUserEvent(state.userList[index-1].username!));
                        },)],
                        ),
                      );
                    }
                ),
              )

          ),
        ),
    );
                              }
                              return Container();
                            },
                          );
  }
}
