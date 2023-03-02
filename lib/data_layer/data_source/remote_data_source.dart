import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class RemoteDataSource {
  Future<User?> createUserWithEmailAndPassword(
      {required String emailAddress, required String password});

  void sendEmailVerification();

  Future<User?> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signOut();

  bool isEmailVerified();
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
    debugPrint(userCredential.user!.email);
    return userCredential.user;
  }

  @override
  void sendEmailVerification() async {
    if (!isEmailVerified()) {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } else {
      return null;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    debugPrint(userCredential.user!.email);
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  bool isEmailVerified() => _firebaseAuth.currentUser!.emailVerified;
}
