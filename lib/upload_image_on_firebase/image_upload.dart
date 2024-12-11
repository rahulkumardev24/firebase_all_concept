import 'dart:io';

import 'package:firebase_concept/upload_image_on_firebase/show_image_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  ImagePicker imagePicker = ImagePicker();
  File? imagePicked;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Upload on Firebase"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              /// here we open image picker for uploading image

              onPressed: () async {
                /// here camera and gallery both open
                final filePicked =
                    await imagePicker.pickImage(source: ImageSource.gallery);

                if (filePicked != null) {
                  imagePicked = File(filePicked.path);
                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: imagePicked != null
                  ? Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: FileImage(imagePicked!),
                              fit: BoxFit.cover)),
                    )
                  : Image.asset(
                      "assets/image.png",
                    ),
            ),
            const SizedBox(
              height: 30,
            ),

            ///------------------------------------- upload button--------------------------------------///
            ElevatedButton(
              onPressed: () async {
                /// when clicking on upload button then image is upload on firebase
                /// simple step
                /// add dependency
                /// SIMPLE CODE
                var storage = FirebaseStorage.instance;
                var storageRef = storage.ref();

                /// user folder/ image folder / then image show
                var imageRef = storageRef.child(
                    "User/images/IMG_${DateTime.now().microsecondsSinceEpoch}.jpg");
                setState(() {
                  isUploading = true;
                });
                await imageRef.putFile(imagePicked!);
                setState(() {
                  isUploading = false;
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white),
              child: isUploading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      "UPLOAD IMAGE",
                      style: TextStyle(fontSize: 20),
                    ),
            ),

            const SizedBox(
              height: 20,
            ),

            /// here we show uploaded image
            ElevatedButton(
              onPressed: () {
                /// here we navigate to show image screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowImageScreen()));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white),
              child: const Text(
                "View Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// IN THIS VIDEO UPLOAD IMAGE AND RETRIEVE IMAGE ON FIREBASE
/// SIMPLE STEP
/// STEP 1
/// CREATE SIMPLE UPLOADING IMAGE UI => Done
/// STEP 2
/// GET START FIREBASE STORAGE => Done
/// STEP 3
/// UPLOAD IMAGE (WRITE SIMPLE CODE) => Done
/// STEP 4
/// RETRIEVE IMAGE (write simple code) => Done
/// here we connect my phone because in emulator have no any image
///
/// FINAL CHECK
///
