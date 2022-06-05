import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwaretutorials/application/auth/authentication/bloc/authentication_bloc.dart';
import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

class CustomDrawer{
	static Drawer get(BuildContext context){
    return Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          children: [
            DrawerHeader(
            
                decoration: const BoxDecoration(
                  color: Colors.white,
                  
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ClipOval(
                        child: Image(
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Ethio Software Tutorial"),
                        const SizedBox(height: 20,),
                        Text("User: "+BlocProvider.of<AuthenticationBloc>(context).preferences.get("username").toString()),
                        Text("Role: "+BlocProvider.of<AuthenticationBloc>(context).preferences.get("role").toString(), style: const TextStyle(fontSize: 13),)
                      ],
                    )
                  ],
                )),
              
            ListTile(
                title: TextButton(
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Edit Profile",
                        style: TextStyle(color: Colors.black)),
                  ),
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context).add(GotoUpdateProfileState());
                  },
                ),
                leading: const Icon(Icons.edit)),
            ListTile(
                title: TextButton(
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: const Text("Logout",
                        style: TextStyle(color: Colors.black)),
                  ),
                  onPressed: () {
                    
        BlocProvider.of<NavigationBloc>(context).add(GotoSignin());
				BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  },
                ),
                leading: const Icon(Icons.logout)),
          ],
        ),
      );
	}
} 
  