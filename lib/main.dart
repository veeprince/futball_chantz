import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok_ui/pages/root_app.dart';
import 'package:tik_tok_ui/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChantsApp());
}

class ChantsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chants',
        theme: ThemeData(brightness: Brightness.dark),
        home: LoginScreen());
  }
}
