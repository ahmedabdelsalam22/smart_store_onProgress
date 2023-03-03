abstract class ProductState {}

class ProductInitialState extends ProductState {}

class FetchProductsLoadingState extends ProductState {}

class FetchProductsSuccessState extends ProductState {}

class FetchProductsErrorState extends ProductState {
  final String error;

  FetchProductsErrorState(this.error);
}
