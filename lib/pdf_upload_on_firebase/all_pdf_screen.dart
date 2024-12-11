import 'package:firebase_concept/pdf_upload_on_firebase/pdf_view_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AllPdfScreen extends StatefulWidget {
  const AllPdfScreen({super.key});

  @override
  State<AllPdfScreen> createState() => _AllPdfScreenState();
}

class _AllPdfScreenState extends State<AllPdfScreen> {
  List<String> pdfList = [];
  bool isLoading = true;

  /// here we create a function for fetching all PDF
  Future<void> fetchPdf() async {
    final storageRef = FirebaseStorage.instance.ref().child("pdf");
    final result = await storageRef.listAll();

    List<String> urls = [];
    for (var item in result.items) {
      final url = await item.getDownloadURL();
      urls.add(url);
    }

    setState(() {
      pdfList = urls;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ---------------------------------  APP BAR ----------------------------------///
      appBar: AppBar(
        title: const Text("All PDF "),
      ),

      /// ---------------------------------- BODY ------------------------------------///
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pdfList.isEmpty
              ? const Center(
                  child: Text("No found PDFs"),
                )
              : Center(
                  child: ListView.builder(
                    itemCount: pdfList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2),
                        child: Card(
                          child: ListTile(
                            /// ______________________   title ________________________
                            title: Text(
                              "PDF : ${index + 1}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),

                            /// ________________________sub title ____________________________
                            subtitle: Text(
                              pdfList[index],
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),

                            /// pdf icon
                            leading: Icon(
                              Icons.picture_as_pdf_rounded,
                              color: Colors.redAccent.shade100,
                            ),

                            /// when click on open button pdf is open
                            /// Navigate to pdfview screen
                            /// and then view PDF
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PdfViewScreen(
                                            pdfUrl: pdfList[index])));
                              },
                              icon: const Icon(Icons.open_in_new),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

/// in this screen all pdf is show
