import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydemo/dataview.dart';

class updatadelete extends StatefulWidget {
  dynamic x;

  updatadelete(this.x);

  @override
  State<updatadelete> createState() => _updatadeleteState();
}

class _updatadeleteState extends State<updatadelete> {
  final ImagePicker _picker = ImagePicker();
  String imagepath = "";
  TextEditingController name = TextEditingController();
  bool st = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.x['name'];
    imagepath = widget.x['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      st = false;
                    });
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imagepath = image!.path;
                    });
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    child: st
                        ? CircleAvatar(
                            backgroundImage: NetworkImage("${imagepath}"),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(imagepath)),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.clear,
                      );
                      if(st)
                        {
                          DatabaseReference ref = FirebaseDatabase.instance.ref("mydemo").child(widget.x['id']);
                          await ref.set({
                            "id":widget.x['id'],
                            "name": name.text,
                            "image":imagepath
                          }).then((value) {
                            EasyLoading.dismiss();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return dataview();
                            },));
                          });
                        }
                      else{
                        final storageRef = FirebaseStorage.instance.ref();
                        final mountainImagesRef =
                        storageRef.child("mydemo/${Random().nextInt(10000)}.jpg");
                        mountainImagesRef.putFile(File(imagepath)).then((p0) {
                          mountainImagesRef.getDownloadURL().then((value) async {

                            DatabaseReference ref = FirebaseDatabase.instance.ref("mydemo").child(widget.x['id']);
                            await ref.set({
                              "id":widget.x['id'],
                              "name": name.text,
                              "image":value
                            }).then((value) {
                              EasyLoading.dismiss();
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return dataview();
                              },));
                            });
                          });
                        });
                      }
                    },
                    child: Text("updata"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
