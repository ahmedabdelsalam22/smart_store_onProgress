import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data_layer/data_source/firestore_remote_data_source.dart';
import '../../data_layer/models/product_model.dart';
import '../../data_layer/models/user_model.dart';

abstract class FireStoreRepository {
  Future<void> uploadUserDataToFireStore(
      {required Map<String, dynamic> data, required String uid});

  Future getUserDataFromFireStore({required String uid});

  Future<List<ProductModel>> getAllProducts();
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

  @override
  Future getUserDataFromFireStore({required String uid}) async {
    final response = await _remoteDataSource.getDataFromFireStore(
      collection: 'users',
      doc: uid,
    );
    final result = response.data as List;
    final userData = result.map((e) => UserModel.fromJson(e)).toList();
    return userData;
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    final products = snapshot.docs.map((e) => ProductModel.fromMap(e)).toList();
    return products;
  }
}
