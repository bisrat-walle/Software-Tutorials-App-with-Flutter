import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/login_response.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        color: const Color.fromARGB(0, 34, 34, 204),
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _loginFormKey,
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 150,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: _usernameController,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Enter your username",
                    contentPadding: EdgeInsets.fromLTRB(1, 0, 0, 5),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.account_circle),
                    ),
                    prefixStyle: TextStyle(height: 100.0),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value.toString().length < 5 ||
                        value == null ||
                        value.isEmpty) {
                      return 'password is required and must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Enter your password",
                    contentPadding: EdgeInsets.fromLTRB(1, 0, 0, 5),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.password_rounded),
                    ),
                    prefixStyle: TextStyle(height: 100.0),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value.toString().length < 5 ||
                        value == null ||
                        value.isEmpty) {
                      return 'username is required and must be at least 5 characters';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    print({
                      "username": _usernameController.text,
                      "password": _passwordController.text
                    });
                    final res = await authenticateUser(username:_usernameController.text, password: _passwordController.text);
                    print(res.accessToken);
                    if (_loginFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }
}
