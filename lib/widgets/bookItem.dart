import 'package:flutter/material.dart';
import '../pages/singleBookPage.dart';

Widget buildBookItem(BuildContext context, String imagePath, String bookName, String pdfUrl) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () {
        // Navigate to the single book page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => singleBookPage(
              bookName: bookName,
              pdfUrl: pdfUrl,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amberAccent, // Move the color here into BoxDecoration
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath, // Added height for the image for consistency
                  fit: BoxFit.cover, // Ensures the image covers the container properly
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                bookName,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
