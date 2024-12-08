
import 'package:flutter/material.dart';
import 'package:pfe_book/api/book.dart';
import '../calcul/calcul.dart';
import '../pages/singleBookPage.dart';

Widget miniBuildBookItem(
    BuildContext context,
    String imagePath,
    String bookName,
    String pdfUrl,
    String bookId,
    String creatorId,
    String userId,
    String createdAt,
    int views,
    BookApi bookApi
    ) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () {
        // Remove 'const' here as you're passing dynamic parameters
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleBookPage(
              bookName: bookName,  // Pass the dynamic bookName
              pdfUrl: pdfUrl,      // Pass the dynamic pdfUrl
              bookId: bookId,
              bookApi: bookApi,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amberAccent,
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
                Image.network(
                  imagePath,
                  height: 100,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.7), // Semi-transparent background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 9, // Adjusted size for a more subtle appearance
                        ),
                        const SizedBox(width: 4), // Added spacing between the icon and text
                        Text(
                          views.toString(), // Replace '1' with a dynamic view count if needed
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),Positioned(
                  top: 8,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.7), // Semi-transparent background
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(20), left: Radius.circular(0)), // Adjusted border radius(20),
                    ),
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.white,
                          size: 9, // Adjusted size for a more subtle appearance
                        ),
                        const SizedBox(width: 4), // Added spacing between the icon and text
                        Text(
                          Calc().formatYearRange(createdAt),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
