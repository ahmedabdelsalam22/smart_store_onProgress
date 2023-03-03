import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/models/product_model.dart';
import 'firestore_state.dart';

class FireStoreCubit extends Cubit<FireStoreState> {
  FireStoreCubit() : super(FireStoreInitialState());

  static FireStoreCubit get(context) => BlocProvider.of(context);

  static List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts {
    return _productsList;
  }

  Future<void> fetchProducts() async {
    emit(FetchProductsLoadingState());
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              price: double.parse(element.get('price')),
              salePrice: double.parse(element.get('salePrice')),
              isOnSale: element.get('isOnSale'),
              isDiscount: element.get('isDiscount'),
              details: element.get('details'),
            ));
      });
      emit(FetchProductsSuccessState());
    }).catchError((onError) {
      emit(FetchProductsErrorState(onError.toString()));
    });
  }
}
