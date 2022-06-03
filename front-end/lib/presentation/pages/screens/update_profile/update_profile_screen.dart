import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softwaretutorials/domain/core/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwaretutorials/presentation/pages/components/custom_snack_bar.dart';
import 'package:softwaretutorials/presentation/pages/screens/signup/bloc/signup_bloc.dart';
import 'package:softwaretutorials/presentation/pages/screens/update_profile/bloc/update_profile_bloc.dart';

import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen();
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}


class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;
  late TextEditingController _roleController;
  late TextEditingController _newPasswordController;
 

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _roleController = TextEditingController();
    _fullNameController = TextEditingController();
    _newPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _updateProfileBloc = UpdateProfileBloc()..add(LoadUserProfileEvent());
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(children: [
            Container(
              color: Colors.white,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset("assets/images/black_corner.svg"),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset("assets/images/purple_corner.svg"),
            ),
            Positioned(
              top: 10,
              left: 15,
              child: SvgPicture.asset("assets/images/brain.svg"),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 150),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("Update Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 30))),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          constraints: BoxConstraints(maxWidth: 500),
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                            listener: (context, state) {
                              if (state is UpdateProfileErrorState)
                              CustomSnackBar.display(context, CustomSnackBar.get(state.error));
                            },
                            bloc: _updateProfileBloc,
                            builder: (context, state) {
                              if (state is UpdateProfileCompletedState) {
                                BlocProvider.of<NavigationBloc>(context).add(GotoAllTutorials());
                              }
                              if (state is UpdateProfileLoadingState)
                                return Center(child: CircularProgressIndicator());
                              if (state is UserProfileLoadedState){
                                _usernameController.text = state.user.username!;
                                _emailController.text = state.user.email!;
                                _fullNameController.text = state.user.fullName!;
                              }
                              return Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                              controller: _fullNameController,
                                                              validator: (value) {
                                                                if (value == null ||
                                                                    value.isEmpty ||
                                                                    value.length < 6) {
                                                                  return "please enter your full name (at least 6 chars)";
                                                                }
                                                                return null;
                                                              },
                                                              style: TextStyle(color: Colors.black),
                                                              keyboardType: TextInputType.text,
                                                              decoration: InputDecoration(
                          
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                                  constraints: BoxConstraints(maxHeight: 60),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10),
                                                                      borderSide:
                                                                          BorderSide(color: Colors.black)),
                                                                  fillColor: Color(0xffC4C4C4).withOpacity(.5),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10),
                                                                      borderSide:
                                                                          BorderSide(color: Colors.black)),
                                                                  hintText: "Full Name",
                                                                  filled: true,
                                                                  suffixIcon: Icon(Icons.person_outline_outlined),
                                                                  hintStyle: TextStyle(color: Color(0xff000000)),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10)))),
                                                          SizedBox(height: 10),
                                                          TextFormField(
                                                              controller: _usernameController,
                                                              validator: (value) {
                                                                if (value == null ||
                                                                    value.isEmpty ||
                                                                    value.length < 5) {
                                                                  return "please enter your username (at least 5 chars)";
                                                                }
                                                                return null;
                                                              },
                                                              style: TextStyle(color: Colors.black),
                                                              decoration: InputDecoration(
                          
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                                  constraints: BoxConstraints(maxHeight: 60),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  fillColor: Color(0xffC4C4C4).withOpacity(.5),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  hintText: "Username",
                                                                  filled: true,
                                                                  suffixIcon: Icon(Icons.person_outline_outlined),
                                                                  hintStyle: TextStyle(color: Color(0xff000000)),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10)))),
                                                          SizedBox(height: 10),
                                                          TextFormField(
                                                              controller: _emailController,
                                                              validator: (value) {
                                                                if (value == null ||
                                                                    value.isEmpty ||
                                                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                        .hasMatch(value)) {
                                                                  return "enter a valid email";
                                                                }
                                                                return null;
                                                              },
                                                              style: TextStyle(color: Colors.black),
                                                              keyboardType: TextInputType.emailAddress,
                                                              decoration: InputDecoration(
                          
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                                  constraints: BoxConstraints(maxHeight: 60),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  fillColor: Color(0xffC4C4C4).withOpacity(.5),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  hintText: "Email",
                                                                  filled: true,
                                                                  suffixIcon: Icon(Icons.email_outlined),
                                                                  hintStyle: TextStyle(color: Color(0xff000000)),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10))),),
                                                          SizedBox(height: 10),
                                                          TextFormField(
                                                            obscureText: true,
                                                              controller: _passwordController,
                                                              validator: (value) {
                                                                if (value == null ||
                                                                    value.isEmpty ||
                                                                    value.length < 8) {
                                                                  return "password is required and must be at least 8 chars";
                                                                }
                                                              },
                                                              style: TextStyle(color: Colors.black),
                                                              keyboardType: TextInputType.visiblePassword,
                                                              decoration: InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                                  constraints: BoxConstraints(maxHeight: 60),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  fillColor: Color(0xffC4C4C4).withOpacity(.5),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  hintText: "Password",
                                                                  filled: true,
                                                                  suffixIcon: Icon(Icons.password_outlined),
                                                                  hintStyle: TextStyle(color: Color(0xff000000)),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10))),),
                                                          SizedBox(height: 10),

                                                          TextFormField(
                                                            obscureText: true,
                                                              controller: _newPasswordController,
                                                              validator: (value) {
                                                                if (value == null ||
                                                                    value.isEmpty ||
                                                                    value.length < 8) {
                                                                  return "password is required and must be at least 8 chars";
                                                                }
                                                              },
                                                              style: TextStyle(color: Colors.black),
                                                              keyboardType: TextInputType.visiblePassword,
                                                              decoration: InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                                  constraints: BoxConstraints(maxHeight: 60),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  fillColor: Color(0xffC4C4C4).withOpacity(.5),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      borderSide:
                                                                      BorderSide(color: Colors.black)),
                                                                  hintText: "New Password (if you want to change)",
                                                                  filled: true,
                                                                  suffixIcon: Icon(Icons.password_outlined),
                                                                  hintStyle: TextStyle(color: Color(0xff000000)),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10))),),
                                                          SizedBox(height: 10),
                                                          
                                                          Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(width: 10,),
                                                            SizedBox(width: 50,),
                                                          ]),
                                                          SizedBox(height: 10),
                                                          SizedBox(
                                                              width: 400,
                                                              height: 35,
                                                              child: ElevatedButton(
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty
                                                                        .resolveWith<Color>(
                                                                      (Set<MaterialState> states) {
                                                                        if (states.contains(
                                                                            MaterialState.pressed))
                                                                          return Colors.blue;
                                                                        return Colors
                                                                            .teal; // Use the component's default.
                                                                      },
                                                                    ),
                                                                  ),
                                                                  child: state is UpdateProfileLoadingState ? Text("Updating ... ", style: TextStyle(fontSize: 18),) : Text("Update Profile", style: TextStyle(fontSize: 18),),
                                                                  onPressed: state is SignupLoadingState? null : ()  {
                                                                    if(_formKey.currentState!.validate()){
                                                                      _updateProfileBloc.add(AttemptProfileUpdateEvent(
                                                                          email: _emailController.text,
                                                                          username: _usernameController.text,
                                                                          fullName:  _fullNameController.text,
                                                                          password: _passwordController.text,
                                                                          ));
                                                                    }
                                                                  })),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _fullNameController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
