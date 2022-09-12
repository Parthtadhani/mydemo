import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mydemo/hello.dart';

class emailpassword extends StatefulWidget {
  const emailpassword({Key? key}) : super(key: key);

  @override
  State<emailpassword> createState() => _emailpasswordState();
}

class _emailpasswordState extends State<emailpassword> {
  String soo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: "email",
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 3))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    hintText: "password",
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 3))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(soo),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    )
                        .then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return loginemail();
                        },
                      ));
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Sudmit")),
          ],
        ),
      ),
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}

class loginemail extends StatefulWidget {
  const loginemail({Key? key}) : super(key: key);

  @override
  State<loginemail> createState() => _loginemailState();
}

class _loginemailState extends State<loginemail> {
  String soo = "";
  bool email1 = false;
  bool pass1 = false;
  bool helloo = true;
  String email2 = "";
  String pass2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: "email",
                    errorText: email1 ? email2 : null,
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 3))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    hintText: "password",
                    errorText: pass1 ? pass2 : null,
                    suffixIcon: InkWell(
                        onTap: () {
                          if (helloo) {
                            setState(() {
                              helloo = false;
                            });
                          } else {
                            setState(() {
                              helloo = true;
                            });
                          }
                        },
                        child: Icon(Icons.remove_red_eye_outlined)),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 3))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(soo),
            ),
            ElevatedButton(
                onPressed: () async {
                  // EasyLoading.show(
                  //   status: 'loading...',
                  //   maskType: EasyLoadingMaskType.clear,
                  // );
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return hello();
                      },
                    ));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      setState(() {
                        email1 = true;
                        email2 = "No user found for that email.";
                      });
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      setState(() {
                        pass1 = true;
                        pass2 = "Wrong password provided for that user";
                      });
                    } else {
                      setState(() {
                        pass1 = false;
                        email1 = false;
                        pass2 = "";
                        email2 = "";
                      });
                    }
                  }
                },
                child: Text("login")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return emailpassword();
                    },
                  ));
                },
                child: Text("new email")),
          ],
        ),
      ),
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}
