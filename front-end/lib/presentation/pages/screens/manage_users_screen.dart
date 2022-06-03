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
                    Center(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Username"),
                                SizedBox(width: 30),
                                IconButton(
                                  icon: Icon(Icons.arrow_drop_up),
                                  onPressed: () {},
                                ),
                                Text("Actions")
                              ],
                            )),
                        // Container(
                        //   color: Colors.white,
                        //   padding: EdgeInsets.only(left: 10, right: 10),
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //         border: OutlineInputBorder(),
                        //         hintText: "search",
                        //         suffixIcon: IconButton(
                        //           icon: Icon(Icons.search),
                        //           onPressed: () {},
                        //         )),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: BlocBuilder<ManageuserBloc, ManageuserState>(
                          bloc: _manageUserBloc,
                          builder: (context, state) {
                            if (state is ManageuserState)
                              return Container(
                                constraints: BoxConstraints(maxWidth: 600)
                                
                                );
                            return CircularProgressIndicator();
                          },
                        )
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
