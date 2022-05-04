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

  Future<UserCredential> signupWithEmail(
      {required String email, required String link}) async {
    return await _firebaseAuth!
        .signInWithEmailLink(email: email, emailLink: link);
  }

  Future<void> sendEmailLink({required String email}) async {
    return _firebaseAuth!.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://balancednewsauth.page.link/',
          handleCodeInApp: true,
          androidPackageName: 'com.example.balanced_news',
          androidMinimumVersion: "1",
        ));
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      _firebaseAuth!.signOut(),
      _googleSignIn!.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth!.currentUser;
    print('here');
    print(currentUser?.email);
    return currentUser != null;
  }

  Future<String> getUser() async {
    return _firebaseAuth!.currentUser!.email!;
  }

  Future<String> getUserPhoto(String email) async {
    return _firebaseAuth!.currentUser!.photoURL ??
        'https://ui-avatars.com/api/?name=$email';
  }
}
