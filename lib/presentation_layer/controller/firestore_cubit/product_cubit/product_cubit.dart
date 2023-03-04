import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_store/presentation_layer/controller/firestore_cubit/product_cubit/product_state.dart';

import '../../../../data_layer/models/product_model.dart';
import '../../../../domain_layer/repository/firestore_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._fireStoreRepository) : super(ProductInitialState());

  final FireStoreRepository _fireStoreRepository;

  static ProductCubit get(context) => BlocProvider.of(context);

  static List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts {
    return _productsList;
  }

  Future getAllProducts() async {
    emit(FetchProductsLoadingState());
    await _fireStoreRepository.getAllProducts().then((value) {
      _productsList = value;
      emit(FetchProductsSuccessState());
    }).catchError((onError) {
      emit(FetchProductsErrorState(onError.toString()));
    });
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }

  ProductModel findProductById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> searchList = _productsList
        .where((element) => element.title.contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }
}
