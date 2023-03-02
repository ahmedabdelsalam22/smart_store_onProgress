import 'package:firebase_auth/firebase_auth.dart';

import '../../data_layer/data_source/firestore_remote_data_source.dart';

abstract class FireStoreRepository {
  Future<void> uploadUserDataToFireStore(
      {required String collection,
      required String doc,
      required Map<String, dynamic> data});
}

class FireStoreRepositoryImpl implements FireStoreRepository {
  final FireStoreRemoteDataSource _remoteDataSource;
  FireStoreRepositoryImpl(this._remoteDataSource);

  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Future<void> uploadUserDataToFireStore({
    required String collection,
    required String doc,
    required Map<String, dynamic> data,
  }) async {
    await _remoteDataSource.uploadDataToFireStore(
      collection: 'users',
      doc: _currentUser!.uid,
      data: data,
    );
  }
}
