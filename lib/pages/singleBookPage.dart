import 'package:flutter/material.dart';
import 'package:pfe_book/api/book.dart';
import 'package:pfe_book/pages/pdfViewr.dart';

class singleBookPage extends StatelessWidget {
  final String bookName;
  final String pdfUrl;
  final String bookId;
  final BookApi bookApi;

  const singleBookPage({super.key, required this.bookName, required this.pdfUrl,required this.bookId, required this.bookApi});

  @override
  Widget build(BuildContext context) {
    bookApi.viewIncrement(bookId);
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
