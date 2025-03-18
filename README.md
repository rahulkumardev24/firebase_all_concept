# 🚀 Firebase Push Notifications in Flutter

This Flutter project integrates **Firebase Cloud Messaging (FCM)** to send and receive push notifications.

---

## 📌 Features
✅ Receive push notifications when the app is in the foreground.  
✅ Display notifications in the system tray when the app is in the background.  
✅ Open the app and navigate based on the notification click.  
✅ Retrieve and print the **FCM Token** for testing.  
✅ Supports background and terminated states.  

---
## Screenshort
<div>
  <img src = "https://github.com/rahulkumardev24/firebase_all_concept/blob/master/Screenshot_20250318_000058.png" height =500 />
   <img src = "https://github.com/rahulkumardev24/firebase_all_concept/blob/master/Screenshot_20250318_000112.png" height =500 />
 </div>

## 🔧 Setup & Installation

### **1️⃣ Create a Firebase Project**
1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Create a new project.
3. Add an **Android app** (Use the package name from `android/app/build.gradle`).
4. Download the **google-services.json** file and place it inside `android/app/`.

### **2️⃣ Enable Firebase Cloud Messaging (FCM)**
- In Firebase Console, go to **Cloud Messaging**.
- Enable **FCM API** in the Google Cloud Console.

### **3️⃣ Add Firebase Dependencies**
In your **pubspec.yaml**, add:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: latest_version
  firebase_messaging: latest_version
```
Run:
```
flutter pub get
```

4️⃣ Android Setup
Modify AndroidManifest.xml (android/app/src/main/AndroidManifest.xml):
```
<service
    android:name=".MyFirebaseMessagingService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
    </intent-filter>
</service>
```
Also, update android/app/build.gradle:
```
defaultConfig {
    minSdkVersion 19
}

```

5️⃣ Initialize Firebase in Flutter
Modify main.dart:

```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

📲 Sending a Test Notification
Run the app on a real device.
Copy the FCM Token from the UI or log.
Go to Firebase Console → Cloud Messaging.
Click Send Notification.
Select FCM Token as the target and paste the copied token.
Click Send and check if you receive the notification.
🚀 How It Works
Foreground State
When a notification arrives, the app updates the UI instead of showing a system notification.
Background State
Notifications appear in the notification tray.
When tapped, the app opens, and the notification data is processed.
Terminated State
Clicking a notification while the app is closed will open it and handle the message.
🛠️ Troubleshooting
1️⃣ Notifications Not Received in Foreground?
By default, FCM notifications do not show system notifications when the app is in the foreground.
To manually handle it:
```
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print("Foreground Notification: ${message.notification?.title}");
});
```
2️⃣ No FCM Token?
Ensure Firebase is properly initialized.
Run flutter clean and restart the app.
Check logs for errors.
3️⃣ App Crashes on Background Notification?
Ensure _firebaseMessagingBackgroundHandler is a top-level function (not inside a class):
```
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background Notification: ${message.notification?.title}");
}
```
Register the background handler in main.dart:
```
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
```
---
```
💡 Additional Resources?
📖 FlutterFire Docs.
🔥 FCM Official Docs.
```
---
📜 License
This project is MIT licensed. Feel free to use and modify it. 🚀



### **📌 Summary of Improvements**
✅ Clean and professional format for GitHub  
✅ Includes setup steps, troubleshooting, and testing instructions  
✅ Well-structured for easy readability  
✅ Uses **Markdown formatting** for better appearance  

Would you like any additional sections or customization? 🚀🔥








