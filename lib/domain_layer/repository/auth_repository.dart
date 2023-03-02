import 'package:firebase_auth/firebase_auth.dart';

import '../../data_layer/data_source/remote_data_source.dart';

abstract class AuthRepository {
  Future<void> createUserWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> createUserWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await _remoteDataSource.createUserWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await _remoteDataSource.signInWithEmailAndPassword(
        emailAddress: emailAddress,
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
    return await _remoteDataSource.signOut();
  }
}
