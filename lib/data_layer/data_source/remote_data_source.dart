import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteDataSource {
  Future<User?> createUserWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<User?> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signOut();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> createUserWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
