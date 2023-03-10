import 'package:firebase_auth/firebase_auth.dart';

import '../../data_layer/data_source/auth_remote_data_source.dart';

abstract class AuthRepository {
  Future<User?> createUserWithEmailAndPassword(
      {required String emailAddress, required String password});

  void sendEmailVerification();

  Future<User?> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signOut();

  bool isEmailVerified();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User?> createUserWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    final user = await _remoteDataSource.createUserWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    return user;
  }

  @override
  void sendEmailVerification() {
    _remoteDataSource.sendEmailVerification();
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    final user = await _remoteDataSource.signInWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    return user;
  }

  @override
  Future<void> signOut() async {
    return await _remoteDataSource.signOut();
  }

  @override
  bool isEmailVerified() => _remoteDataSource.isEmailVerified();
}
