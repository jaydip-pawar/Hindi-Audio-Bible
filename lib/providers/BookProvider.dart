import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier{

  Stream<QuerySnapshot> bookStream = FirebaseFirestore.instance
      .collection('Books')
      .snapshots();

}