import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tik_tok_ui/services/database_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCredential(AuthCredential credential) =>
      _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
  Stream<User> get currentUser => _auth.authStateChanges();
}

class AuthBloc {
  final authService = AuthService(); //This one
  final googleSignin = GoogleSignIn(scopes: ['email']);

  Stream<User> get currentUser => authService.currentUser;
  Map _userObj = {};

  loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignin.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      //Firebase Sign in
      final result = await authService.signInWithCredential(credential);
      await DatabaseService(uid: result.user.email)
          .updateUserData('0', 'new crew', 100);
      print(result.user.uid);
      print('${result.user.displayName}');
    } catch (error) {
      print(error);
    }
  }

  loginFacebook() async {
    try {
      final result = await FacebookAuth.i.login(
        permissions: ['email', 'public_profile'],
      );
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData(
          fields: "name, id, email,picture.width(200)",
        );
        //Firebase Sign in
        final FirebaseAuth _auth = FirebaseAuth.instance;

        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken.token);

        // FirebaseUser is deprecated
        final User user =
            (await authService.signInWithCredential(credential)).user;

        await DatabaseService(uid: userData['id'])
            .updateUserData('0', 'new crew', 100);
      }
    } catch (error) {
      print(error);
    }
  }

  loginApple() {}

  logout() {
    authService.logout();
  }
}
