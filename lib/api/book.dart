import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookApi {
  // Create All Books
  Future<void> addAllBooks() async {
    // Get the current user ID
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print("No user is logged in.");
      return;
    }

    final String currentUserId = currentUser.uid;

    final List<Map<String, dynamic>> books = [
      // Your books data...
    ];

    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var book in books) {
        book["createdAt"] = Timestamp.now();
        book["createdBy"] = currentUserId;
        DocumentReference bookRef = FirebaseFirestore.instance.collection('books').doc(book['id']);
        batch.set(bookRef, book);
      }

      await batch.commit();
      print("All books added successfully!");
    } catch (e) {
      print("Error adding books: $e");
    }
  }

  // Read Books
  Future<List<Map<String, dynamic>>> getBooks() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('books').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching books: $e");
      return [];
    }
  }

  // Update Book
  Future<void> updateBook(String bookId, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance.collection('books').doc(bookId).update(updatedData);
      print("Book updated successfully!");
    } catch (e) {
      print("Error updating book: $e");
    }
  }

  // Delete Book
  Future<void> deleteBook(String bookId) async {
    try {
      await FirebaseFirestore.instance.collection('books').doc(bookId).delete();
      print("Book deleted successfully!");
    } catch (e) {
      print("Error deleting book: $e");
    }
  }
  //view increment
  Future<void> viewIncrement(String bookId) async {
    try {
      await FirebaseFirestore.instance.collection('books').doc(bookId).update({'views': FieldValue.increment(1)});
      print("Book updated successfully!");
    } catch (e) {
      print("Error updating book: $e");
    }
  }
}
