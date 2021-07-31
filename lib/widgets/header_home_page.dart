import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_ui/bloc/auth_block.dart';
import 'package:tik_tok_ui/login.dart';
import 'package:tik_tok_ui/theme/colors.dart';

class HeaderHomePage extends StatefulWidget {
  const HeaderHomePage({
    Key key,
  }) : super(key: key);

  @override
  _HeaderHomePageState createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage> {
  StreamSubscription<User> loginStateSubscription;
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AuthenticationScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignInButton(
          Buttons.Google,
          text: "Log Out",
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          onPressed: () {
            authBloc.logout();
            // Navigator.of(context).pop();
          },
        ),
        // ElevatedButton(
        //   child: Text(
        //     // should be something like homepage instead of following which shows matchweek?
        //     "Match Week",
        //     style: TextStyle(
        //       color: white.withOpacity(0.7),
        //       fontSize: 16,
        //     ),
        //   ),
        //   onPressed: () {
        //     print('Following bar');
        //   },
        // ),
        SizedBox(
          width: 8,
        ),
        Text(
          "|",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: white.withOpacity(0.3),
            fontSize: 17,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          //for you shows favorite team(maybe change the name to something else)
          "For You",
          style: TextStyle(
              color: white, fontSize: 17, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
