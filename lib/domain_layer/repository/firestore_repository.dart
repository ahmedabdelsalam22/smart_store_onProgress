abstract class FireStoreRepository {
  Future<void> uploadUserDataToFireStore(
      {required String collection,
      required String doc,
      required Map<String, dynamic> data});
}

class FireStoreRepositoryImpl implements FireStoreRepository {
  @override
  Future<void> uploadUserDataToFireStore({
    required String collection,
    required String doc,
    required Map<String, dynamic> data,
  }) async {}
}
