import 'package:flutter/material.dart';

class hello extends StatefulWidget {
  const hello({Key? key}) : super(key: key);

  @override
  State<hello> createState() => _helloState();
}

class _helloState extends State<hello> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Text(
          "welcome",
          style: TextStyle(fontSize: 50),
        )),
      ),
    );
  }
}
