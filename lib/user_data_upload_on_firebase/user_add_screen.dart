import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_concept/user_data_upload_on_firebase/all_user_show_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({super.key});

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController mobController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  File? imagePicked;

  bool isUploading = false;

  /// here we create function for upload data on firebase
  /// uploadUserData
  Future<void> uploadUserData() async {
    String name = nameController.text.toString();
    String age = ageController.text.toString();
    String city = cityController.text.toString();
    String mob = mobController.text.toString();

    if (name.isNotEmpty &&
        age.isNotEmpty &&
        city.isNotEmpty &&
        mob.isNotEmpty) {
      setState(() {
        isUploading = true;
      });

      /// image upload on firebase storage
      String imageUrl = '';
      if (imagePicked != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images/${DateTime.now().millisecond}.jpg');
        await storageRef.putFile(imagePicked!);
        imageUrl = await storageRef.getDownloadURL();
      }

      /// upload user details to Firestore

      /// firestore ref
      await FirebaseFirestore.instance.collection("user_collection").add({
        "name": name,
        "age": age,
        "mobile": mob,
        "image": imageUrl,
        "city": city,
        "timestamp": FieldValue.serverTimestamp()
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("user deatils Upload Successfully Upload")));
      setState(() {
        isUploading = false;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fill all the required box")));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// FIRST SCREEN => USER ADD SCREEN
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add User",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),

      /// ----------------------------BODY---------------------------------///
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// ----------------------- PROFILE IMAGE ------------------------///
                imagePicked != null
                    ? Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(300),
                            image: DecorationImage(
                                image: FileImage(imagePicked!),
                                fit: BoxFit.cover)),
                      )
                    : Image.asset(
                        "assets/userImage.png",
                        height: 300,
                        width: 300,
                      ),

                /// ----------------------- image picker button ----------------------------///
                Positioned(
                  bottom: 0,
                  right: 70,
                  child: IconButton(

                      /// here we write code for pick image
                      onPressed: () async {
                        final filePicked = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (filePicked != null) {
                          imagePicked = File(filePicked.path);

                          ///
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.image,
                        size: 60,
                        color: Colors.blue,
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                /// ------------NAME FIELD-------------///
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter user name",
                    label: const Text("Name"),
                    filled: true,
                    fillColor: Colors.lightBlueAccent.shade100.withOpacity(0.6),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                /// ------------AGE FIELD-------------///
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: "Enter user Age",
                    label: const Text("Age"),
                    filled: true,
                    fillColor: Colors.lightBlueAccent.shade100.withOpacity(0.6),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                /// ------------CITY FIELD-------------///
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: "Enter user City",
                    label: const Text("City"),
                    filled: true,
                    fillColor: Colors.lightBlueAccent.shade100.withOpacity(0.6),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// ------------Mobile FIELD-------------///
                TextField(
                  controller: mobController,
                  decoration: InputDecoration(
                    hintText: "Enter user Mob.",
                    label: const Text("Mob.No"),
                    filled: true,
                    fillColor: Colors.lightBlueAccent.shade100.withOpacity(0.6),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.blueAccent)),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// cancel Button
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(

                          /// when press cancel button every thing clear
                          onPressed: () {
                            setState(() {
                              nameController.clear();
                              ageController.clear();
                              mobController.clear();
                              cityController.clear();
                              imagePicked = null;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side:
                                  const BorderSide(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 22, color: Colors.red),
                          )),
                    ),

                    /// add button
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(

                          /// here we call the upload user data function
                          onPressed: () {
                            uploadUserData();

                            /// after uploading all data clear
                            setState(() {
                              nameController.clear();
                              ageController.clear();
                              cityController.clear();
                              mobController.clear();
                              imagePicked = null;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.greenAccent.shade400,
                          ),
                          child: isUploading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                /// ---------------- view all user button  --------------------------///
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(

                      /// Navigate to all user screen
                      /// navigate to All_user_screen
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllUserShowScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueAccent.shade400,
                      ),
                      child: const Text(
                        "View All User",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// IN THIS VIDEO WE UPLOAD USER DETAILS
/// LIKE
/// NAME
/// PROFILE IMAGE
/// AGE
/// MOBILE NO.
/// CITY
///
/// SIMPLE STEP TO UPLOAD USER DATA
/// STEP 1
/// ADD DEPENDENCY  => DONE
/// STEP 2
/// CREATE SIMPLE UI
/// CREATE TO SCREEN
/// FIRST => ADD USER SCREEN => Done
/// SECOND => SHOW ALL USER SCREEN => DONE
/// STEP 3
/// UPLOAD USER DATA ON FIREBASE => Done
/// STEP 4
/// FETCH ALL USER FROM FIREBASE => Done
///

/// LOGIC PART START
///  Image Pick with image picker =>
///  create a function for data upload on firebase
///  ADD USER DATA ON FIREBASE COMPLETE
///
/// FETCH ALL USER DATA => Second screen
///
/// Delete user manual
///
/// FINAL TEST
/// thanks
