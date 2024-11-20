import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class PdfViewer extends StatefulWidget {
  final String url;  // URL of the PDF

  const PdfViewer({super.key, required this.url});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late Uint8List _pdfData;  // To hold the PDF data
  bool _loading = true;      // Loading flag
  double _progress = 0.0;    // Progress bar value (0.0 - 1.0)

  @override
  void initState() {
    super.initState();
    _fetchPdf();
  }

  // Fetch PDF data from the URL with progress tracking
  Future<void> _fetchPdf() async {
    final request = http.Request('GET', Uri.parse(widget.url));
    final response = await request.send();

    final bytes = <int>[];
    int bytesReceived = 0;

    // Get the content length from the response (can be null or 0)
    final contentLength = response.contentLength ?? 0;

    response.stream.listen(
          (List<int> chunk) {
        bytes.addAll(chunk);
        bytesReceived += chunk.length;

        // Update the progress only if contentLength is greater than 0
        if (contentLength > 0) {
          setState(() {
            _progress = bytesReceived / contentLength;
          });
        }
      },
      onDone: () {
        setState(() {
          _pdfData = Uint8List.fromList(bytes);
          _loading = false;  // PDF loaded successfully
        });
      },
      onError: (error) {
        print("Failed to load PDF: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? SingleChildScrollView(  // Make the Column scrollable if needed
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              const CircularProgressIndicator(
                color: Colors.amber,
              ),
              const SizedBox(height: 20),
              Text(
                '${(_progress * 100).toStringAsFixed(2)}%', // Display percentage
                style: const TextStyle(fontSize: 20, color: Colors.amber),
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: _progress, // Set progress bar value
                backgroundColor: Colors.amber.withOpacity(0.3), // Background with transparency
                color: Colors.amberAccent,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ],
          ),
        ),
      )
          : PDFView(
        pdfData: _pdfData,  // Provide PDF data to the PDF viewer
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageFling: true,
        pageSnap: true,
      ),
    );
  }
}
