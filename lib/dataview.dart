// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
//
// class dataview extends StatefulWidget {
//   const dataview({Key? key}) : super(key: key);
//
//   @override
//   State<dataview> createState() => _dataviewState();
// }
//
// class _dataviewState extends State<dataview> {
//   var data;
//   DatabaseReference starCountRef = FirebaseDatabase.instance.ref('mydemo');
//   late DatabaseReference databaseReference;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get();
//   }
//
//   void get() {
//
//     starCountRef.onValue.listen((DatabaseEvent event) {
//       data = event.snapshot.value;
//       print(data);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           children: [
//             FirebaseAnimatedList(
//                 itemBuilder: (context, snapshot, animation, index) {
//                   return ListTile(
//                     title: Text(snapshot.value['id']),
//                     );
//                 },
//                 query: starCountRef),
//           ],
//         )
//             );
//   }
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mydemo/updatadelete.dart';

class dataview extends StatefulWidget {
  const dataview({Key? key}) : super(key: key);

  @override
  State<dataview> createState() => _dataviewState();
}

class _dataviewState extends State<dataview> {
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref("mydemo");
  bool st=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  void get() {
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      setState(() {
        st=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return st?Scaffold(
      body: SafeArea(
          child: FirebaseAnimatedList(
        itemBuilder: (context, snapshot, animation, index) {
          dynamic x=snapshot.value;
          print("================================${x}");
          return Card(
            elevation: 16,
            child: Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 1,
                    onPressed: (context) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return  updatadelete(x);
                      },));
                    },
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.update,
                    label: 'update',
                  ),
                  SlidableAction(
                    flex: 1,
                    onPressed: (context) {
                      showDialog(
                        builder: (context) {
                          return AlertDialog(
                            title: Text("detele data"),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    DatabaseReference ref = FirebaseDatabase.instance.ref("mydemo").child(x['id']);
                                    ref.remove();

                                  },
                                  child: Text("Ok"))
                            ],
                          );
                        },
                        context: context,
                      );
                    },
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'delete',
                  ),
                ],
              ),
              child: ListTile(
                  title: Text("${x['name']}"),
                leading: Image.network("${x['image']}",height: 50,width: 50,),
                  ),
            ),
          );
        },
        query: starCountRef,
      )),
    ):Center(child: CircularProgressIndicator());
  }
}
