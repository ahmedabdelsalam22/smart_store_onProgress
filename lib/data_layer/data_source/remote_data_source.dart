import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteDataSource {
  Future<void> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signOut();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  var _authInstance = FirebaseAuth.instance;

  @override
  Future<void> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }
}
