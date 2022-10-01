import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> login(
      {required String email, required String password});

  Future<UserCredential> signUp(
      {required String email,
      required String password,
      String? name,
      String? phone});

  Future<UserCredential> googleSignIn();
}

class AuthRemoteDataSourceimpl extends BaseService
    implements AuthRemoteDataSource {
  // firebase auth needs to be injected
  @override
  Future<UserCredential> googleSignIn() async {
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
  }

  @override
  Future<UserCredential> login(
      {required String email, required String password}) async {
    UserCredential loginResult = await auth.signInWithEmailAndPassword(
        email: email.toString(), password: password.toString());

    return loginResult;
  }

  @override
  Future<UserCredential> signUp(
      {required String email,
      required String password,
      String? name,
      String? phone}) async {
    final newUser = await auth.createUserWithEmailAndPassword(
        email: email.toString(), password: password.toString());

    return newUser;
  }
}
