import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class fbb extends StatefulWidget {
  const fbb({Key? key}) : super(key: key);

  @override
  State<fbb> createState() => _fbbState();
}

class _fbbState extends State<fbb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              signInWithFacebook().then((value) {
                print(value);
              });
            }, child: Text("fb_login")),
            ElevatedButton(onPressed: () {

            }, child: Text("logout"))
          ],
        ),
      ),
    );
  }
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

}
