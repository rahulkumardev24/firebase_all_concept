import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_concept/pdf_upload_on_firebase/all_pdf_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PdfUploadScreen extends StatefulWidget {
  const PdfUploadScreen({super.key});

  @override
  State<PdfUploadScreen> createState() => _PdfUploadScreenState();
}

class _PdfUploadScreenState extends State<PdfUploadScreen> {
  File? selectedFile;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload PDF on firebase"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ----------------------------------------- FILE SELECTION BUTTON -------------------------------------------///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom, allowedExtensions: ["pdf"]);
                  if (result != null && result.files.single.path != null) {
                    setState(() {
                      /// file is selected
                      selectedFile = File(result.files.single.path!);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: selectedFile != null
                    ? const Icon(
                        Icons.picture_as_pdf,
                        size: 300,
                        color: Colors.redAccent,
                      )
                    : Image.asset(
                        "assets/file-storage.png",
                        height: 300,
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            /// ---------------------------------------------------------- PDF UPLOADING BUTTON ------------------------///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                /// when click on PDF UPLOAD button pdf is upload
                onPressed: () async {
                  setState(() {
                    isUploading = true;
                  });
                  final storageRef = FirebaseStorage.instance
                      .ref()
                      .child("pdf/${selectedFile!.path.split('/')}");
                  await storageRef.putFile(selectedFile!);
                  setState(() {
                    isUploading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.blue,
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: isUploading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text(
                        "PDF UPLOAD",
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            ),

            /// ----------------------------------------- VIEW PDF SCREEN ------------------------------///
            /// View all my pdf navigate to other screen
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllPdfScreen()));
                },
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.blue,
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: isUploading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text(
                        "VIEW PDF",
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// IN THIS VIDEO UPLOAD pdf ON FIREBASE AND GET pdf
/// SIMPLE STEP
/// Step 1
/// ADD ALL DEPENDENCY   => DONE
/// STEP 2
/// CREATE SIMPLE PDF UPLOADING UI => done
/// STEP 3
/// UPLOAD ALL PDF  => Done
/// STEP 4
/// GET ALL PDF   => DONE
/// STEP 5
/// VIEW ALL PDF    => DONE
/// uploading time depending on network speed
/// know time to retrieve  all uploaded file

/// CHECK COMPLETE CODE
