import 'package:flutter/material.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({super.key});

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Push Notification"),
      ),
    );
  }
}

/// IN THIS VIDEO WE IMPLEMENT FIREBASE PUSH NOTIFICATION
/// STEP 1
/// CONNECT FIREBASE WITH FLUTTER => this is already done
/// step 2
/// start notification in your firebase project
/// step 3
/// read documentation
/// STEP 4
/// COPY THE TOKEN
