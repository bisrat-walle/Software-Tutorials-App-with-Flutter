import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:softwaretutorials/presentation/core/authentication/bloc/authentication_bloc.dart';

class CustomDrawer{
	static Drawer get(BuildContext context){
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          children: [
            DrawerHeader(
            
                decoration: BoxDecoration(
                  color: Colors.white,
                  
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                        child: Image(
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text("Ethio Software Tutorial"),
                        Text(authBloc.preferences.get("username").toString())
                      ],
                    )
                  ],
                )),
              
            ListTile(
                title: TextButton(
                  child: Text("Manage Users",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {},
                ),
                leading: Icon(Icons.people)),
            ListTile(
                title: TextButton(
                  child: Text("Manage Tutorials",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {},
                ),
                leading: Icon(Icons.school)),
            ListTile(
                title: TextButton(
                  child: Text(
                    "Statistics",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
                leading: Icon(Icons.numbers),),
                ListTile(
                  title: TextButton(child:Text("Logout"), onPressed: () {
				
				authBloc.add(LoggedOut());
			
			}),
                )
          ],
        ),
      );
	}
} 
  