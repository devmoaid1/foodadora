// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:foodadora/models/customer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  final Logger logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _instance = FirebaseAuth.instance;

  Stream<User?> getUserStream() {
    return _instance.authStateChanges();
  }

  String get userName => _instance.currentUser?.displayName ?? "";

  bool get isAuthed => _instance.currentUser != null;

  Future<UserCredential> emailLogin({String? email, String? password}) async {
    try {
      UserCredential loginResult = await _instance.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());

      return loginResult;
    } on FirebaseAuthException catch (e) {
      logger.e("error", e.message, e.stackTrace);
      throw e.message.toString();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCrediential = await _instance.signInWithCredential(credential);

      // Once signed in, return the UserCredential
      return userCrediential;
    } on PlatformException catch (e) {
      logger.e(
        "error",
        e.message,
      );
      throw e.message.toString();
    }
  }

  Future<UserCredential> signUp(
      {String? email, String? password, String? name, String? phone}) async {
    try {
      final newUser = await _instance.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());

      addCustomerToFirebase(
          email: newUser.user!.email,
          name: name,
          phone: phone,
          id: newUser.user!.uid);

      return newUser;
    } on FirebaseAuthException catch (e) {
      logger.e("error", e.message, e.stackTrace);
      throw e.message.toString();
    }
  }

  Future<void> addCustomerToFirebase(
      {String? id,
      String? email,
      String? name,
      String? phone,
      String? photoUrl}) async {
    Customer newCustomer = Customer(
        userId: id,
        email: email,
        name: name,
        phoneNumber: phone,
        photoUrl: photoUrl);

    try {
      await _firestore.collection('customers').add(newCustomer.toJson());
    } on FirebaseException catch (err) {
      logger.e(err.message.toString());
      throw err.message.toString();
    }
  }

  // Future<void> saveCustomerToFirebase(
  //     String id, String name, String email, String phone) async {
  //   var options = SetOptions(merge: true);
  //   await _firestore
  //       .collection('customers')
  //       .doc(id)
  //       .set({'name': name, 'email': email, 'phone': phone}, options);
  // }

  Future<void> logout() async {
    try {
      await _instance.signOut();
    } on FirebaseAuthException catch (e) {
      logger.e("error", e.message, e.stackTrace);
      throw e.message.toString();
    }
  }
}
