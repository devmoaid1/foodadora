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

      // Once signed in, return the UserCredential
      return await _instance.signInWithCredential(credential);
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
          email: newUser.user!.email, name: name, phone: phone);

      return newUser;
    } on FirebaseAuthException catch (e) {
      logger.e("error", e.message, e.stackTrace);
      throw e.message.toString();
    }
  }

  void addCustomerToFirebase({String? email, String? name, String? phone}) {
    Customer newCustomer =
        Customer(email: email, name: name, phoneNumber: phone);

    try {
      _firestore.collection('customers').add(newCustomer.toJson());
    } on FirebaseException catch (err) {
      logger.e(err.message.toString());
      throw err.message.toString();
    }
  }

  void saveCustomerToFirebase(
      String id, String name, String email, String phone) {
    var options = SetOptions(merge: true);
    _firestore
        .collection('customers')
        .doc(id)
        .set({'name': name, 'email': email, 'phone': phone}, options);
  }

  Future<void> logout() async {
    try {
      await _instance.signOut();
    } on FirebaseAuthException catch (e) {
      logger.e("error", e.message, e.stackTrace);
      throw e.message.toString();
    }
  }
}
