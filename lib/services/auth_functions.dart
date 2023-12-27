// ignore_for_file: use_build_context_synchronously

import 'package:deepak_kumar_task/services/firbase_functions.dart';
import 'package:deepak_kumar_task/widgets/snack_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static signInUser(String email, String password, BuildContext context,
      Map<String, dynamic> args) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, '/profile', arguments: {
        'email': '${args['email']}',
        'imageUrl': '${args['imageUrl']}',
        'name': '${args['name']}'
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackBarWidget(context, 'no user found with this email');
      } else if (e.code == 'invalid-credential') {
        snackBarWidget(context, 'password did not match');
      }
    } catch (e) {
      snackBarWidget(context, e.toString());
    }
  }

  static signUpUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(
          '', name, email, userCredential.user!.uid, context);
      snackBarWidget(context, 'Registered successfully');
      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackBarWidget(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        snackBarWidget(context, 'The account already exists for that email.');
      }
    } catch (e) {
      snackBarWidget(context, e.toString());
    }
  }
}
