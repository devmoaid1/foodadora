// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:foodadora/features/auth/data/models/customer_model.dart';

import 'package:foodadora/services/base_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends BaseService {
  Stream<User?> get authState => auth.authStateChanges();

  Stream<User?> getUserStream() {
    return auth.authStateChanges();
  }

  String get userName => auth.currentUser?.displayName ?? "";

  bool get isAuthed => auth.currentUser != null;

  Future<UserCredential> emailLogin({String? email, String? password}) async {
    try {
      UserCredential loginResult = await auth.signInWithEmailAndPassword(
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

      final userCrediential = await auth.signInWithCredential(credential);

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
      final newUser = await auth.createUserWithEmailAndPassword(
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
    CustomerModel newCustomer = CustomerModel(
        userId: id,
        email: email,
        name: name,
        phoneNumber: phone,
        photoUrl: photoUrl);

    try {
      await firestore.collection('customers').add(newCustomer.toJson());
    } on FirebaseException catch (err) {
      logger.e(err.message.toString());
      throw err.message.toString();
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      logger.e("error", e.message, e.stackTrace);
      throw e.message.toString();
    }
  }
}
