import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);
}
