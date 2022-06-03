import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

class CustomDrawer{
	static Drawer get(BuildContext context){
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text("Ethio Software Tutorial"),
                        SizedBox(height: 20,),
                        Text("User: "+BlocProvider.of<AuthenticationBloc>(context).preferences.get("username").toString()),
                        Text("User: "+BlocProvider.of<AuthenticationBloc>(context).preferences.get("Role").toString(), style: TextStyle(fontSize: 13),)
                      ],
                    )
                  ],
                )),
              
            ListTile(
                title: TextButton(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Edit Profile",
                        style: TextStyle(color: Colors.black)),
                  ),
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context).add(GotoUpdateProfileState());
                  },
                ),
                leading: Icon(Icons.edit)),
            ListTile(
                title: TextButton(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Logout",
                        style: TextStyle(color: Colors.black)),
                  ),
                  onPressed: () {
                    
				BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        BlocProvider.of<NavigationBloc>(context).add(GotoSignin());
                  },
                ),
                leading: Icon(Icons.logout)),
          ],
        ),
      );
	}
} 
  