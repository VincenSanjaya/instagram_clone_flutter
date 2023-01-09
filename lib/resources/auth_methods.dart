import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage(
            'profilePics', file, false);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        res = "Success Sign In";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Invalid Email";
      } else if (err.code == 'email-already-in-use') {
        res = "Email Already In Use";
      } else if (err.code == 'weak-password') {
        res = "Weak Password";
      }
    }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Login User
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success Log In";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Invalid Email";
      } else if (err.code == 'user-not-found') {
        res = "User Not Found";
      } else if (err.code == 'wrong-password') {
        res = "Wrong Password";
      }
    }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
