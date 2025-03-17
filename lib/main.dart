import 'package:firebase_concept/Firebase%20Notification/push_notification_screen.dart';
import 'package:firebase_concept/pdf_upload_on_firebase/pdf_upload_screen.dart';
import 'package:firebase_concept/phone%20Authentication/phone_auth_screen.dart';
import 'package:firebase_concept/upload_image_on_firebase/image_upload.dart';
import 'package:firebase_concept/user_data_upload_on_firebase/user_add_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background Notifications Received : ${message.notification?.title}" ) ;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /// Background & Terminated state listener
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler) ;
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Push Notification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PushNotificationScreen(),
    );
  }
}

/// IN THIS VIDEO CONNECT FLUTTER WITH FIREBASE (DIFFERENT ACCOUNT )
/// SIMPLE STEP
/// STEP 1
/// CREATE ACCOUNT IN FIREBASE
/// STEP 2
/// CREATE NEW FLUTTER PROJECT
/// STEP 3
/// LOGOUT THE FIREBASE USING COMMEND
/// STEP 4
/// AGAIN LOGIN WITH DIFFERENT ACCOUNT
/// FLOW THE SIMPLE STEP
/// already login
/// first logout the current account
///  LOGOUT COMMENT IS :: firebase logout
///  successfully login
///  know connect
/// successfully connect
/// check option file add or not
/// add dependency
/// check
/// connect
/// final check
///
/// THANKS FOR WATCHING
///
