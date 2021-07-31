import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_ui/bloc/auth_block.dart';
import 'package:tik_tok_ui/pages/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => AuthBloc(),
        child: MaterialApp(
          home: RootApp(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
