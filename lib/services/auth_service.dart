import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SIGN UP
  Future<User?> signUp(
    String email,
    String password,
  ) async {
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  // LOGIN
  Future<User?> signIn(
    String email,
    String password,
  ) async {
    UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  // LOGOUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // CURRENT USER
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}