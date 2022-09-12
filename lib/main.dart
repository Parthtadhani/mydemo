import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mydemo/demo.dart';
import 'package:mydemo/emailpassword.dart';
import 'package:mydemo/google.dart';
import 'package:mydemo/phone.dart';
import 'package:slider_button/slider_button.dart';

import 'fbb.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(),
    home: sss(),
  ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class sss extends StatefulWidget {
  const sss({Key? key}) : super(key: key);

  @override
  State<sss> createState() => _sssState();
}

class _sssState extends State<sss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: SliderButton(
                action: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return demo();
                    },
                  ));
                },

                ///Put label over here
                label: Text(
                  "add data end view data",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Center(
                    child: Icon(
                  Icons.label_important_outline_sharp,
                  color: Colors.white,
                  size: 40.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                )),

                ///Change All the color and size from here.
                width: 300,
                radius: 10,
                buttonColor: Color(0xffd60000),
                backgroundColor: Color(0xff534bae),
                highlightedColor: Colors.white,
                baseColor: Colors.red,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: SliderButton(
                action: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return phone();
                    },
                  ));
                },

                ///Put label over here
                label: Text(
                  "phone number opt",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Center(
                    child: Icon(
                  Icons.label_important_outline_sharp,
                  color: Colors.white,
                  size: 40.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                )),

                ///Change All the color and size from here.
                width: 300,
                radius: 10,
                buttonColor: Color(0xffd60000),
                backgroundColor: Color(0xff534bae),
                highlightedColor: Colors.white,
                baseColor: Colors.red,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: SliderButton(
                action: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return google();
                    },
                  ));
                },

                ///Put label over here
                label: Text(
                  "google login",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Center(
                    child: Icon(
                  Icons.label_important_outline_sharp,
                  color: Colors.white,
                  size: 40.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                )),

                ///Change All the color and size from here.
                width: 300,
                radius: 10,
                buttonColor: Color(0xffd60000),
                backgroundColor: Color(0xff534bae),
                highlightedColor: Colors.white,
                baseColor: Colors.red,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: SliderButton(
                action: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return loginemail();
                    },
                  ));
                },

                ///Put label over here
                label: Text(
                  "email password",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Center(
                    child: Icon(
                  Icons.label_important_outline_sharp,
                  color: Colors.white,
                  size: 40.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                )),

                ///Change All the color and size from here.
                width: 300,
                radius: 10,
                buttonColor: Color(0xffd60000),
                backgroundColor: Color(0xff534bae),
                highlightedColor: Colors.white,
                baseColor: Colors.red,
              ),
            ),Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: SliderButton(
                action: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return fbb();
                    },
                  ));
                },

                ///Put label over here
                label: Text(
                  "fbb",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Center(
                    child: Icon(
                      Icons.label_important_outline_sharp,
                      color: Colors.white,
                      size: 40.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    )),

                ///Change All the color and size from here.
                width: 300,
                radius: 10,
                buttonColor: Color(0xffd60000),
                backgroundColor: Color(0xff534bae),
                highlightedColor: Colors.white,
                baseColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
