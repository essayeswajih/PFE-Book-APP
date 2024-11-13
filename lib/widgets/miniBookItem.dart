import 'package:flutter/material.dart';

Widget miniBuildBookItem(String imagePath, String bookName) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.amberAccent,  // Move the color here into BoxDecoration
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
                imagePath,
                height: 100,  // Added height for the image for consistency
                fit: BoxFit.cover,  // Ensures the image covers the container properly
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
              style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
