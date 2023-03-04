import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/firebase_constance.dart';
import '../../../data_layer/models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  Map<String, CartModel> _cartItems = {};

  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> getCart() async {
    final User? user = FireBaseConstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();

    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get('userCart').length;
    for (int i = 0; i < leng; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('userCart')[i]['productId'],
          () => CartModel(
              id: userDoc.get('userCart')[i]['cartId'],
              productId: userDoc.get('userCart')[i]['productId'],
              quantity: userDoc.get('userCart')[i]['quantity']));
    }
  }
}
