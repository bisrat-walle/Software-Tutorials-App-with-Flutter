import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softwaretutorials/domain/core/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwaretutorials/infrastructure/tutorials/profile_service.dart';
import 'package:softwaretutorials/presentation/pages/components/custom_snack_bar.dart';
import 'package:softwaretutorials/presentation/pages/screens/signup/bloc/signup_bloc.dart';

import 'package:softwaretutorials/presentation/routes/bloc/navigation_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen();

  static MaterialPage page() {
    return MaterialPage(
      name: TutorialPages.signupPath,
      key: ValueKey(TutorialPages.signupPath),
      child: SignupScreen(),
    );
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _role = "CLIENT";
  final _formKey = GlobalKey<FormState>();
  late String _confirm = "";
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;
  late TextEditingController _roleController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _roleController = TextEditingController();
    _fullNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _signupBloc =
        SignupBloc(RepositoryProvider.of<ProfileRepository>(context));
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
                  padding: EdgeInsets.only(top: 180),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("Sign Up",
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
                          child: BlocConsumer<SignupBloc, SignupState>(
                            listener: (context, state) {
                              if (state is SignupErrorState)
                                CustomSnackBar.display(
                                    context, CustomSnackBar.get(state.error));
                            },
                            bloc: _signupBloc,
                            builder: (context, state) {
                              if (state is SignupCompletedState) {
                                BlocProvider.of<NavigationBloc>(context)
                                    .add(GotoSignin());
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 0),
                                            constraints:
                                                BoxConstraints(maxHeight: 60),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            fillColor: Color(0xffC4C4C4)
                                                .withOpacity(.5),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Full Name",
                                            filled: true,
                                            suffixIcon: Icon(
                                                Icons.person_outline_outlined),
                                            hintStyle: TextStyle(
                                                color: Color(0xff000000)),
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 0),
                                            constraints:
                                                BoxConstraints(maxHeight: 60),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            fillColor: Color(0xffC4C4C4)
                                                .withOpacity(.5),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Username",
                                            filled: true,
                                            suffixIcon: Icon(
                                                Icons.person_outline_outlined),
                                            hintStyle: TextStyle(
                                                color: Color(0xff000000)),
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
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          constraints:
                                              BoxConstraints(maxHeight: 60),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          fillColor:
                                              Color(0xffC4C4C4).withOpacity(.5),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Email",
                                          filled: true,
                                          suffixIcon:
                                              Icon(Icons.email_outlined),
                                          hintStyle: TextStyle(
                                              color: Color(0xff000000)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      obscureText: true,
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 8) {
                                          return "password is required and must be at least 8 chars";
                                        } else {
                                          _confirm = value;
                                        }
                                      },
                                      style: TextStyle(color: Colors.black),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          constraints:
                                              BoxConstraints(maxHeight: 60),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          fillColor:
                                              Color(0xffC4C4C4).withOpacity(.5),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Password",
                                          filled: true,
                                          suffixIcon:
                                              Icon(Icons.password_outlined),
                                          hintStyle: TextStyle(
                                              color: Color(0xff000000)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text('Register as',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                )),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: "CLIENT",
                                                    groupValue: _role,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        this._role =
                                                            value.toString();
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("CLIENT")
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Radio(
                                                    value: "INSTRUCTOR",
                                                    groupValue: _role,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        this._role =
                                                            value.toString();
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("INSTRUCTOR")
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                        ]),
                                    SizedBox(height: 10),
                                    SizedBox(
                                        width: 400,
                                        height: 35,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
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
                                            child: state is SignupLoadingState
                                                ? Text(
                                                    "Loading ... ",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )
                                                : Text(
                                                    "Sign up",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                            onPressed: state
                                                    is SignupLoadingState
                                                ? null
                                                : () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _signupBloc.add(AttemptSignupEvent(
                                                          email:
                                                              _emailController
                                                                  .text,
                                                          username:
                                                              _usernameController
                                                                  .text,
                                                          fullName:
                                                              _fullNameController
                                                                  .text,
                                                          password:
                                                              _passwordController
                                                                  .text,
                                                          role: _role!));
                                                    }
                                                  })),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Already a user?"),
                                        TextButton(
                                          child: Text("login"),
                                          onPressed: () async {
                                            BlocProvider.of<NavigationBloc>(
                                                    context)
                                                .add(GotoSignin());
                                          },
                                        )
                                      ],
                                    )
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
    super.dispose();
  }
}
