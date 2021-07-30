import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok_ui/pages/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RootApp(),
  ));
}
