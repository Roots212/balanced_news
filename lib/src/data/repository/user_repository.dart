// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth? _firebaseAuth;
  final GoogleSignIn? _googleSignIn;

  UserRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();


  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth!.signInWithCredential(credential);
    return _firebaseAuth!.currentUser!;
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    return await _firebaseAuth!.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<Future<List<void>>> signOut() async { 
    return Future.wait([
      _firebaseAuth!.signOut(),
      _googleSignIn!.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth!.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return _firebaseAuth!.currentUser!.email!;
  }
    Future<String> getUserPhoto() async {
    return _firebaseAuth!.currentUser!.photoURL!;
  }
}
