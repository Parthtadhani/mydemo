import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mydemo/hello.dart';

class google extends StatefulWidget {
  const google({Key? key}) : super(key: key);

  @override
  State<google> createState() => _googleState();
}

class _googleState extends State<google> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                signInWithGoogle().then((value) {
                  print(value);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return hello();
                  },));
                });
              }, child: Text("google login")),
              ElevatedButton(onPressed: () async {
                final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
              }, child: Text("logout")),
            ],
          ),
        ),
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
