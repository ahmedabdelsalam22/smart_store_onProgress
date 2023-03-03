import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/models/product_model.dart';
import '../../../domain_layer/repository/firestore_repository.dart';
import 'firestore_state.dart';

class FireStoreCubit extends Cubit<FireStoreState> {
  FireStoreCubit(this._fireStoreRepository) : super(FireStoreInitialState());

  final FireStoreRepository _fireStoreRepository;

  static FireStoreCubit get(context) => BlocProvider.of(context);

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

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }
}