import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydemo/hello.dart';

class phone extends StatefulWidget {
  const phone({Key? key}) : super(key: key);

  @override
  State<phone> createState() => _phoneState();
}

class _phoneState extends State<phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: TextField(
                      controller: num,
                      keyboardType: TextInputType.phone,
                      autofillHints: [AutofillHints.telephoneNumber],
                      maxLength: 10,
                      decoration: InputDecoration(
                          hintText: "num",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                  ),
                ),
                InkWell(onTap: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+91 ${num.text}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      setState(() {
                        sendotp=verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Text("send otp"),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: otp,
                decoration: InputDecoration(
                    hintText: "otp",
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 3))),
              ),
            ),
            ElevatedButton(onPressed: () async {

              String smsCode = '${otp.text}';

              // Create a PhoneAuthCredential with the code
              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: sendotp, smsCode: smsCode);

              // Sign the user in (or link) with the credential
              await auth.signInWithCredential(credential).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return hello();
                },));
              });
            }, child: Text("Sudmit otp"))
          ],
        ),
      ),
    );
  }
  String sendotp="";
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController num = TextEditingController();
  TextEditingController otp = TextEditingController();
}
