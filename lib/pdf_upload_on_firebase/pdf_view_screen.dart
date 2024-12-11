import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatefulWidget {
  String pdfUrl ;
  PdfViewScreen({super.key , required this.pdfUrl});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View PDF"),),
      body: SfPdfViewer.network(widget.pdfUrl),
    ) ;
  }
}

/// PDF VIEW SCREEN DONE
///  final check
///
/// THANKS FOR WATCHING