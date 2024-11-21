import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfe_book/api/book.dart';
import '../widgets/drawer.dart';
import '../widgets/miniBookItem.dart';
import '../widgets/bookItem.dart';
import 'loginPage.dart'; // Assuming you have a LoginPage

class Homepage extends StatefulWidget {
  final String title;
  Homepage({super.key, required this.title});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  late BookApi bookApi;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    bookApi = BookApi();
    _searchController.addListener(_onSearchChanged);

    // Listen for changes in authentication state
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // If the user is logged out, navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),  // Replace with your login page
        );
      }
    });
  }

  // Called whenever search query changes
  void _onSearchChanged() {
    if (_searchController.text != _searchQuery) {
      setState(() {
        _searchQuery = _searchController.text;
        _isLoading = true;  // Show loading indicator when search query changes
      });

      // Simulate a delay to mimic a real search operation (e.g., fetching from Firestore)
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;  // Hide loading indicator after delay
        });
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            const SizedBox(
              height: 30,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/YXUjAZj.png'),
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading books'));
          }

          final books = snapshot.data ?? [];
          final filteredBooks = books
              .where((book) => book['title']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
              .toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchBar(),
                const SizedBox(height: 30),
                _buildNewsSection(filteredBooks),
                const SizedBox(height: 30),
                _buildVerticalBookList(filteredBooks),
              ],
            ),
          );
        },
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add a new book
          _showAddBookDialog();
        },
      )
    );
  }

  // Fetch books from Firestore using the BookApi
  Future<List<Map<String, dynamic>>> _fetchBooks() async {
    try {
      // Assuming the API is adding books to Firestore
      //await bookApi.addAllBooks();

      // Fetch books from Firestore
      final snapshot = await _firestore.collection('books').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching books: $e");
      return [];
    }
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
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              labelText: 'Search',
              suffixIcon: _searchQuery.isEmpty
                  ? const Icon(Icons.search)
                  : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged(); // Reset search query
                },
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }


  Widget _buildNewsSection(List<Map<String, dynamic>> books) {
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
            _buildHorizontalBookList(books),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalBookList(List<Map<String, dynamic>> books) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          print(book);
          return miniBuildBookItem(
            context, book["image"] ?? "",
            book["title"] ?? "",
            book["pdf"] ?? "",
            book["id"] ?? "",
            book["createdBy"] ?? "",
            currentUser!.uid ?? "",
            book["createdAt"].toString() ?? "",
            book["views"] ?? 0,
            bookApi
          );
        },
      ),
    );
  }

  Widget _buildVerticalBookList(List<Map<String, dynamic>> books) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0, top: 15, bottom: 20, right: 17),
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
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return buildBookItem(
                    context, book["image"] ?? "",
                    book["title"] ?? "",
                    book["pdf"] ?? "",
                    book["id"] ?? "",
                    book["createdBy"] ?? "",
                    currentUser!.uid ?? "",
                    book["createdAt"].toString() ?? "",
                    book["views"] ?? 0,
                    bookApi
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  void _showAddBookDialog() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _authorController = TextEditingController();
    final TextEditingController _imageUrlController = TextEditingController();
    final TextEditingController _pdfUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.amber,
          title: const Text("Add New Book",style: TextStyle(color: Colors.white),),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _authorController,
                    decoration: const InputDecoration(
                      labelText: "Author",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an author";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(
                      labelText: "Image URL",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an image URL";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _pdfUrlController,
                    decoration: const InputDecoration(
                      labelText: "PDF URL",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a PDF URL";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => Navigator.pop(context),
                  child: const Row(
                    children: [
                      Text("Cancel"),
                      SizedBox(width: 5),
                      Icon(Icons.cancel),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.green),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Generate a new document reference to get the ID
                      final docRef = _firestore.collection('books').doc();
                      final newBookId = docRef.id;

                      // Define the book data including the generated ID
                      final newBook = {
                        "title": _titleController.text.trim(),
                        "author": _authorController.text.trim(),
                        "image": _imageUrlController.text.trim(),
                        "pdf": _pdfUrlController.text.trim(),
                        "likes": 0,
                        "views": 0,
                        "downloads": 0,
                        "createdAt": DateTime.now().toString(),
                        "createdBy": currentUser?.uid ?? "Anonymous",
                        "id": newBookId, // Add the document ID as an attribute
                      };

                      try {
                        // Save the document to Firestore
                        await docRef.set(newBook);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Book added successfully!")),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error adding book: $e")),
                        );
                      }
                    }
                  },
                  child: const Row(
                    children: [
                      Text("Save"),
                      SizedBox(width: 5),
                      Icon(Icons.save),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
