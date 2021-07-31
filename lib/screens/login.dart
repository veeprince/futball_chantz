import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tik_tok_ui/screens/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SignInButton(
      Buttons.Google,
      onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen())),
    ));
  }
}
