import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUserShowScreen extends StatefulWidget {
  const AllUserShowScreen({super.key});

  @override
  State<AllUserShowScreen> createState() => _AllUserShowScreenState();
}

class _AllUserShowScreenState extends State<AllUserShowScreen> {
  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection("user_collection");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All User List",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),

      /// ___________BODY___________//
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: userCollections.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No Data is Found"),
                );
              }

              final users = snapshot.data!.docs;
              return GridView.builder(
                  itemCount: users.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5 / 6,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    final user = users[index].data() as Map<String, dynamic>;
                    final String name = user['name'] ?? "unKnow";
                    final String age = user['age'] ?? "unKnow";
                    final String city = user['city'] ?? "unKnow";
                    final String mob = user['mobile'] ?? "unKnow";
                    final String userProfile =
                        user['image'] ?? "assets/userImage.png";
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade200,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// _____________user profile____________________///
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(userProfile),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name : $name",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text("Age : $age",
                                      style: const TextStyle(fontSize: 18)),
                                  Text("City : $city",
                                      style: const TextStyle(fontSize: 18)),
                                  Text("mob : $mob",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.blueAccent))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          )),
    );
  }
}

/// second screen
/// all user view screen
/// ui part done
///  IN THIS SCREEN WE FETCH ALL USER DATA
/// Done fetch all user data
/// final check
