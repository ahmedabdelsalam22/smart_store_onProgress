import '../../data_layer/data_source/auth_remote_data_source.dart';

abstract class AuthRepository {
  Future<void> createUserWithEmailAndPassword(
      {required String emailAddress, required String password});

  void sendEmailVerification();

  Future<void> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signOut();

  bool isEmailVerified();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> createUserWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    await _remoteDataSource.createUserWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
  }

  @override
  void sendEmailVerification() {
    _remoteDataSource.sendEmailVerification();
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    await _remoteDataSource.signInWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    return await _remoteDataSource.signOut();
  }

  @override
  bool isEmailVerified() => _remoteDataSource.isEmailVerified();
}
