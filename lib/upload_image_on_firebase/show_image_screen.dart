import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ShowImageScreen extends StatefulWidget {
  const ShowImageScreen({super.key});

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  /// here we show all uploaded image
  List<String> imageUrls = [];
  bool isLoading = true;

  /// here we creating function for fetching image
  Future<void> fetchUserImage() async {
    /// storage ref
    final storageRef = FirebaseStorage.instance.ref().child("User/images");
    final ListResult result = await storageRef.listAll();

    /// here we apply for loop for fetch all image
    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      imageUrls.add(url);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    /// here we call fetch image function for already image is firebase
    fetchUserImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show image "),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(imageUrls[index]),
                              fit: BoxFit.cover)),
                    );
                  }),
            ),
    );
  }
}

/// show image screen done
/// THANKS FOR WATCHING
/// THANKS
