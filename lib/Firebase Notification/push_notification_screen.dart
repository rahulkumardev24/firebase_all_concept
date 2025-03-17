import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  /// here we create function to get FCM Token
  void _setUpFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    /// get FCM Token
    String? token = await messaging.getToken();
    print("MY FCM Token : $token");

    ///  if app is close then message is show in notifications bar
    /// if message is open then show in dialog box
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Forground Notifications : ${message.notification?.title}");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(message.notification?.title ?? "No Title Found"),
                content: Text(message.notification?.body ?? "No body found"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"))
                ],
              ));
    });

    /// When a notification is tapped and the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification Clicked : ${message.notification?.title}");
    });

    /// if the app was opened from a terminated state via a notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(
            "App is Opened from Terminated State : ${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    super.initState();

    /// here we call the functions
    _setUpFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pus Notification",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Push Notifications ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
    );
  }
}

/// In this video we implement push notifications with firebase in simple step
/// Step 1 => Done
/// Connect Flutter project with firebase , in you are not able to connect first link the project link in the description box
/// Step 2 => Done
/// add Dependency firebase_messaging
/// Step 3 => Done
/// Simple Code
/// Step 4 => Done
/// Send message from firebase connect project
///
/// Check complete code and final test
/// Thanks
