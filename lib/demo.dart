import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydemo/dataview.dart';
import 'package:mydemo/phone.dart';

import 'emailpassword.dart';
import 'google.dart';


class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  final ImagePicker _picker = ImagePicker();
  String imagepath = "pic.png";
  bool pic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  pic = true;
                  imagepath = image!.path;
                });
              },
              child: Container(
                  height: 200,
                  width: 200,

                  child: pic
                      ? CircleAvatar(
                    backgroundImage: FileImage(File(imagepath)),
                  )
                      : Container(

                      child: CircleAvatar(
                          child: Icon(Icons.add_a_photo_sharp)))),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    border:
                    OutlineInputBorder(borderSide: BorderSide(width: 3))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.clear,
                  );
                  final storageRef = FirebaseStorage.instance.ref();
                  final mountainImagesRef =
                  storageRef.child("mydemo/${Random().nextInt(10000)}.jpg");
                  mountainImagesRef.putFile(File(imagepath)).then((p0) {
                    mountainImagesRef.getDownloadURL().then((value) async {
                      DatabaseReference ref =
                      FirebaseDatabase.instance.ref("mydemo").push();
                      String? id = ref.key;

                      await ref.set({
                        "id": id,
                        "name": name.text,
                        "image": value
                      }).then((value) {
                        EasyLoading.dismiss();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return dataview();
                          },
                        ));
                      });
                      print(value);
                    });
                  });
                },
                child: Text("add")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return dataview();
                    },
                  ));
                },
                child: Text("view"))
          ],
        ),
      ),
    );
  }

  TextEditingController name = TextEditingController();
}
