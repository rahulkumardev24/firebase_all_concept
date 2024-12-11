import 'package:firebase_concept/pdf_upload_on_firebase/pdf_upload_screen.dart';
import 'package:firebase_concept/upload_image_on_firebase/image_upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  /// make sure this line add

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PdfUploadScreen()
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
