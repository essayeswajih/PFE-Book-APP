import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';

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

    // Define the books JSON array
    final List<Map<String, dynamic>> books = [
      {
        "title": "SECURAS",
        "author": "SECURAS",
        "image": "https://drive.google.com/uc?export=download&id=12dMd9ETnEbfPb66J1VU6TsXwv3EWfDDx",
        "pdf": "https://drive.google.com/uc?export=download&id=18JZBVExPvi2snFq9OOjbxclmQAo1HG6M",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
    ];

    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var book in books) {
        // Add dynamic fields
        book["createdAt"] = Timestamp.now();
        book["createdBy"] = currentUserId;

        // Generate a new document ID for each book
        DocumentReference bookRef = FirebaseFirestore.instance.collection('books').doc();
        book["id"] = bookRef.id; // Save the generated ID in the book data

        batch.set(bookRef, book);
      }

      // Commit the batch
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
