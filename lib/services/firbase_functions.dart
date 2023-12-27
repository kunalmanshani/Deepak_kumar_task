import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deepak_kumar_task/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  static saveUser(
      String imageUrl, String name, email, uid, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name, 'imageUrl': imageUrl});
    snackBarWidget(context, 'User Updated Successfuly');
  }
}
