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
        "title": "IMSR",
        "author": "IMSR",
        "image": "https://i.imgur.com/K5hySTI.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1vUOGvbDqWoZdpORXingI48RLZ8xCa6lC",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Focus",
        "author": "Focus",
        "image": "https://i.imgur.com/6c7VTUd.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1377YJzEZn16oDEptRIPJHIooyZosB-oZ",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Qu2Data",
        "author": "Qu2Data",
        "image": "https://i.imgur.com/XgbbICj.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1UbxDBW8_A4Hs8lZdDYm_H96WbBOEm65F",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "AMECAP",
        "author": "AMECAP",
        "image": "https://i.imgur.com/TPZldEJ.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1PQTRMbipHjoJ2Bd3rbJI7gLnCTbdfpwm",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "LAB619",
        "author": "LAB619",
        "image": "https://i.imgur.com/FPqz27B.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1XwIoIMWi9om1YAmndnw7VLpeYa9paaWR",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "COCONSULT",
        "author": "COCONSULT",
        "image": "https://i.imgur.com/IiNdo1M.jpeg",
        "pdf": "https://drive.google.com/uc?export=download&id=1lgYDjUIOlAEnphbsEaMLskz1D-XMYjxq",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "ENOVA ROBOTICS",
        "author": "ENOVA ROBOTICS",
        "image": "https://i.imgur.com/qdh4Vf1.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1778CFut7fh7yOa0-edFm_yHqsCDPzJfQ",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "VIBLIDEA",
        "author": "VIBLIDEA",
        "image": "https://i.imgur.com/88R2WJg.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1rnx1EQn68cinbYFEvABd2B8OWgSaKsNQ",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "WiseVision",
        "author": "WiseVision",
        "image": "https://i.imgur.com/63Esh9P.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1B7bm_dd_7UhlfDUCgxsB4TZaa8DSHxtL",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "WeFactory",
        "author": "WeFactory",
        "image": "https://i.imgur.com/JqRNikc.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1Ejl-ybxu6tXU1TecRS4eH2Q90nSa5Q-u",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "YECIN",
        "author": "YECIN",
        "image": "https://i.imgur.com/XdS72jm.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1D5ywj0kqdqlM3euQWo_hl7OYKs8WtgEQ",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "VERSE",
        "author": "VERSE",
        "image": "https://i.imgur.com/gZBExxN.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1Ooh0bqKqTLtDvNTj5l5hGa45Wyaz43OS",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "VALUE",
        "author": "VALUE",
        "image": "https://i.imgur.com/1bjsZ29.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1pZ_kUpzEqNlDSH-C92qyM6mLKZq59NDp",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Sofrecom",
        "author": "Sofrecom",
        "image": "https://i.imgur.com/sAgU60K.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1RuGx6D0DsbotiFzve7Knfi79u6aeEmwM",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "SeeKMake",
        "author": "SeeKMake",
        "image": "https://i.imgur.com/yAo10Xw.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1weL7nnjwGbtiAhMr8JrsSR42BDCzD2a5",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "SaveYourWardrobe",
        "author": "SaveYourWardrobe",
        "image": "https://i.imgur.com/6sqdsF7.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1lVyC8nB9qVMzM1Wb6bI9AfT9drYXMyzf",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "primatec",
        "author": "primatec",
        "image": "https://i.imgur.com/j97Rh8b.png",
        "pdf": "https://drive.google.com/uc?export=download&id=13aqDAHw1EQ2Ex3CHUgU6jWMRMBqDUNmq",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Poulina Group",
        "author": "Poulina Group",
        "image": "https://i.imgur.com/kI3cC3D.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1MsdTdk_571WJ4lzX8tRLcljXjwidimJT",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "PixiStaffing",
        "author": "PixiStaffing",
        "image": "https://i.imgur.com/GCgpJWf.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1EbfUvMkz0IGGm1wnq6q7ZOMsLKmFHfDY",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "pencils consulting",
        "author": "pencils consulting",
        "image": "https://i.imgur.com/sRhEnZR.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1F9YjVc7_ak43fhtkptKIANT9YfxFoRja",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Pearls Consulting",
        "author": "Pearls Consulting",
        "image": "https://i.imgur.com/Au9v910.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1yjkYZdBiXRv81d6xaqPvm86HBSwvhPfp",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "MASS ANALYTICS",
        "author": "MASS ANALYTICS",
        "image": "https://i.imgur.com/Fy1XEcs.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1AY2LT37RyGV3FSBpW-YBFhpKYMfmOr1V",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "LEONI",
        "author": "LEONI",
        "image": "https://i.imgur.com/UA6HxxW.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1KxsYyuZZiQqSyPLnJYceJukAXNy0Hnzx",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "KPMG",
        "author": "KPMG",
        "image": "https://i.imgur.com/Z015App.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1WAheAka0ZbHCPupPMf880KP44Ze6DLp-",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "KarwiSoft",
        "author": "KarwiSoft",
        "image": "https://i.imgur.com/xNMMH6h.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1hlaSWXZWodm3lY-OGoP99dzxiTTx50Pe",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Kamioun",
        "author": "Kamioun",
        "image": "https://i.imgur.com/1J33RdQ.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1ZNJw4oDYqJD9z7W-pmup0RDLD7zFbH56",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Inetum",
        "author": "Inetum",
        "image": "https://i.imgur.com/7nerHLg.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1a3DdKB7y6HU_fzfxgw3jle0adf_Dpbr4",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Hydatis",
        "author": "Hydatis",
        "image": "https://i.imgur.com/UphrjxW.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1ksdxCP5oAf_WP_juHN1vZdM9yojt98NR",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "HoutaLik",
        "author": "HoutaLik",
        "image": "https://i.imgur.com/Wig84nm.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1lf07llxrLWeYR6em9I4bAvK8HYI7r0-f",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Freedom Of Dev",
        "author": "Freedom Of Dev",
        "image": "https://i.imgur.com/rMu9p1R.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1olgFsy29yiAQOoTZmV_6t64NfRbYuYI-",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "FINLOGIK",
        "author": "FINLOGIK",
        "image": "https://i.imgur.com/IeXYxT6.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1xjspbLZ5LNDlNYTK7SHgEaQqYAAEdLha",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Fast Consulting",
        "author": "Fast Consulting",
        "image": "https://i.imgur.com/7UFzk4h.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1pbmABaltjno6iCC7qnYDKrVAwzB55ycl",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "ELEDIS",
        "author": "ELEDIS",
        "image": "https://i.imgur.com/uw4YgFY.png",
        "pdf": "https://drive.google.com/uc?export=download&id=11FV0LAb9UA2owZCGD24rdCGyNo5dW2PO",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "EFREKIADEV",
        "author": "EFREKIADEV",
        "image": "https://i.imgur.com/UEWpIxs.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1FssxPTq5XueLnA9qSebeHoO_3DDlrU5Z",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "DNEXT",
        "author": "DNEXT",
        "image": "https://i.imgur.com/6bnnJ0p.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1-4kxpivVOGFvYKaLYjb2fRMATiczTDhf",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "DLS Gaming",
        "author": "DLS Gaming",
        "image": "https://i.imgur.com/lhkP7JP.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1DNvA2CXooTJ_c5wvlMlhqolpUPSz8fu_",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      },
      {
        "title": "Celestial Wave Digital",
        "author": "Celestial Wave Digital",
        "image": "https://i.imgur.com/Yfdku1S.png",
        "pdf": "https://drive.google.com/uc?export=download&id=1L_SxU7XGklJrH0U4wSQIcQ5Jn-cK8zRX",
        "likes": 0,
        "views": 0,
        "downloads": 0,
        "createdAt": "DateTime.now().toString()",
        "createdBy": "currentUser?.uid ?? Anonymous",
        "id": "newBookId"
      }
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
