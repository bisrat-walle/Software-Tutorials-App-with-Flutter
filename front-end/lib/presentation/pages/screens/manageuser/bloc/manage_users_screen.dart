// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softwaretutorials/presentation/pages/screens/manageuser/bloc/manageuser_bloc.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen();
  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<bool> selected = List<bool>.generate(20, (int index) => false);
  @override
  Widget build(BuildContext context) {
    final _manageUserBloc = ManageuserBloc();
    _manageUserBloc.add(GotoManageUserScreenEvent());
    return Container(
      child: Stack(children: [
          Container(
              child: SvgPicture.asset("assets/images/admin_bg.svg",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover)),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              
              constraints: BoxConstraints(maxWidth: 600),
              margin: EdgeInsets.only(top: 10,left: 10,right: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: BlocBuilder<ManageuserBloc, ManageuserState>(
                            bloc: _manageUserBloc,
                            builder: (context, state) {
                              if (state is ManageUserLoading)
                                return Center(child: CircularProgressIndicator(),);
                              if (state is ManageuserState) {
                                return Container(
                                  // constraints: BoxConstraints(maxWidth: 600),
                                  height:MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile();
                                    },
                                  ),
                                  );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          )
                        ),
                      ),
                    ),
                ),
                  ],
                ),
              ),
            ),
          )
        ]),
    );
  }
}
