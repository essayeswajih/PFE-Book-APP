import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../widgets/miniBookItem.dart'; // Ensure the book item widget is imported correctly.
import '../widgets/bookItem.dart';

class Homepage extends StatefulWidget {
  final String title;

  const Homepage({super.key, required this.title});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, String>> books = [
    {"image": "assets/images/2OJ13ts.png", "title": "Book 2"},
    {"image": "assets/images/6bnnJ0p.png", "title": "Book 3"},
    {"image": "assets/images/IHhPZTh.png", "title": "Book 4"},
    {"image": "assets/images/lhkP7JP.png", "title": "Book 5"},
    {"image": "assets/images/QXFS7iw.png", "title": "Book 6"},
    {"image": "assets/images/YXUjAZj.png", "title": "Book 7"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 30),
            _buildNewsSection(),
            const SizedBox(height: 30),
            _buildVerticalBookList(),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: const Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              labelText: 'Search',
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildNewsSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "News",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            _buildHorizontalBookList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalBookList() {
    return SizedBox(
      height: 130, // Adjust height as needed for horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return miniBuildBookItem(book["image"]!, book["title"]!);
        },
      ),
    );
  }

  Widget _buildVerticalBookList() {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 17.0,top:15, bottom: 20,right: 17),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "All Books",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                shrinkWrap: true, // Allows ListView to work inside a Column
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return buildBookItem(book["image"]!, book["title"]!);
                },
              ),
            ],
          ),
        ),
    );
  }
}
