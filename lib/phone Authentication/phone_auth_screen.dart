import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'otp_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendOTP() async {
    String phoneNumber = "+91${phoneController.text.trim()}";

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Verification failed")));
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone Authentication")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Mobile Number ",
              style: TextStyle(fontSize: 21),
            ),
            const SizedBox(
              height: 12,
            ),
            Pinput(
              length: 10,
              showCursor: true,
              controller: phoneController,

              /// Styling
              defaultPinTheme: PinTheme(
                width: 50,
                textStyle: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400),
                ),
              ),

              /// Focused Box
              focusedPinTheme: PinTheme(
                width: 50,
                textStyle: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color when focused
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.blue, width: 2), // Border color on focus
                ),
              ),

              /// Error State (If input is invalid)
              errorPinTheme: PinTheme(
                width: 50,
                textStyle: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
                decoration: BoxDecoration(
                  color: Colors.red.shade100, // Light red background on error
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red, width: 2),
                ),
              ),

              /// Styling when submitted
              submittedPinTheme: PinTheme(
                width: 50,
                textStyle: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.blueAccent
                      .withOpacity(0.3), // Light green background
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.blueAccent.shade100, width: 2),
                ),
              ),
            ),

            /*   TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Enter phone number"),
            ),*/
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendOTP,
              child: const Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
