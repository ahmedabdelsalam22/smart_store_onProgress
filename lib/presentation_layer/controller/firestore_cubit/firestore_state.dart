abstract class FireStoreState {}

class FireStoreInitialState extends FireStoreState {}

class FetchProductsLoadingState extends FireStoreState {}

class FetchProductsSuccessState extends FireStoreState {}

class FetchProductsErrorState extends FireStoreState {
  final String error;

  FetchProductsErrorState(this.error);
}
