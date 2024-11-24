import 'package:flutter/material.dart';

class constructionPage extends StatelessWidget {
  const constructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Under Construction',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image
            Image.asset(
              'assets/images/construction.png',
              width: 200,
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}