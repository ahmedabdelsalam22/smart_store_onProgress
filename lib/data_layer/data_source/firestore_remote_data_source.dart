import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStoreRemoteDataSource {
  Future<void> uploadDataToFireStore(
      {required String collection,
      required String doc,
      required Map<String, dynamic> data});

  Future getDataFromFireStore({
    required String collection,
    required String doc,
  });
}

class FireStoreRemoteDataSourceImpl implements FireStoreRemoteDataSource {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<void> uploadDataToFireStore(
      {required String collection,
      required String doc,
      required Map<String, dynamic> data}) async {
    await _fireStore.collection(collection).doc(doc).set(data);
  }

  @override
  Future getDataFromFireStore({
    required String collection,
    required String doc,
  }) async {
    return await _fireStore.collection(collection).doc(doc).get();
  }
}
