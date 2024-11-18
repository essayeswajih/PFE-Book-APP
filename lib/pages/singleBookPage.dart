import 'package:flutter/material.dart';
import 'package:pfe_book/pages/pdfViewr.dart';

class singleBookPage extends StatelessWidget {
  final String bookName;
  final String pdfUrl;

  const singleBookPage({Key? key, required this.bookName, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
            bookName,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ), // Display book name in the app bar
      ),
      body: PdfViewer(url: pdfUrl), // Pass the pdfUrl to PdfViewer
    );
  }
}
