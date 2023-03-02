import '../../data_layer/data_source/firestore_remote_data_source.dart';

abstract class FireStoreRepository {
  Future<void> uploadUserDataToFireStore(
      {required Map<String, dynamic> data, required String uid});
}

class FireStoreRepositoryImpl implements FireStoreRepository {
  final FireStoreRemoteDataSource _remoteDataSource;

  FireStoreRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> uploadUserDataToFireStore(
      {required Map<String, dynamic> data, required String uid}) async {
    await _remoteDataSource.uploadDataToFireStore(
      collection: 'users',
      doc: uid,
      data: data,
    );
  }
}
