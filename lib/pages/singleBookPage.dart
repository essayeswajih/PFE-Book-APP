import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pfe_book/api/book.dart';
import 'package:pfe_book/pages/pdfViewr.dart';

class SingleBookPage extends StatelessWidget {
  final String bookName;
  final String pdfUrl;
  final String bookId;
  final BookApi bookApi;

  const SingleBookPage({
    Key? key,
    required this.bookName,
    required this.pdfUrl,
    required this.bookId,
    required this.bookApi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Increment view count
    bookApi.viewIncrement(bookId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          bookName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Display the PDF viewer
          PdfViewer(url: pdfUrl),

          // Add a bottom action bar for buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              /*child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Eye icon (view count)
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove_red_eye, color: Colors.black87),
                  ),

                  // Download button
                  IconButton(
                    onPressed: () async {
                      await downloadBook(context, pdfUrl);
                    },
                    icon: const Icon(Icons.download, color: Colors.black87),
                  ),

                  // Edit button
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.edit, color: Colors.black87),
                  ),

                  // Remove button
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove, color: Colors.black87),
                  ),
                ],
              ),*/
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadBook(BuildContext context, String pdfUrl, {String? customFileName}) async {
    try {
      // Validate the URL
      if (!Uri.parse(pdfUrl).isAbsolute) {
        throw ArgumentError("Invalid URL: $pdfUrl");
      }

      // Initialize Dio for the download request
      Dio dio = Dio();

      // Get the directory for saving the file
      var directory = await getApplicationDocumentsDirectory();

      // Create a default or custom file name
      String fileName = customFileName ?? "downloaded_book.pdf";
      String savePath = "${directory.path}/$fileName";

      // Notify user about download start
      Fluttertoast.showToast(
        msg: "Download started...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
      );

      // Start downloading the file with progress tracking
      await dio.download(
        pdfUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total) * 100;
            Fluttertoast.showToast(
              msg: "Downloading: ${progress.toStringAsFixed(1)}%",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.amberAccent,
              textColor: Colors.white,
            );
          }
        },
      );

      // Verify that the file exists after download
      if (await File(savePath).exists()) {
        Fluttertoast.showToast(
          msg: "✅ Download completed! File saved at: $savePath",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber,
          textColor: Colors.white,
        );
      } else {
        throw FileSystemException("Download failed: File was not saved.");
      }
    } on DioError catch (dioError) {
      Fluttertoast.showToast(
        msg: "❌ Network error: ${dioError.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } on FileSystemException catch (fsError) {
      Fluttertoast.showToast(
        msg: "❌ File system error: ${fsError.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } on ArgumentError catch (argError) {
      Fluttertoast.showToast(
        msg: "❌ Argument error: ${argError.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "❌ Unexpected error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
