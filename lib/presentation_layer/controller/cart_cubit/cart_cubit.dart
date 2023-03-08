import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> getCart() async {
    emit(GetCartLoadingState());
    final User? user = FirebaseAuth.instance.currentUser;

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
              ));
    }
    emit(GetCartSuccessState());
  }

  // remove one item from cart
  Future<void> removeOneItem({
    required String cartId,
    required String productId,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {
          'cartId': cartId,
          'productId': productId,
        }
      ]),
    });

    _cartItems.remove(productId);
    await getCart();
    emit(RemoveFromCartSuccessState());
  }

  Future<void> clearOnlineCart() async {
    final User? user = FirebaseAuth.instance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userCart': [],
    });
    _cartItems.clear();
  }

  // delete or clear all items in one click ..
  void clearLocalCart() {
    _cartItems.clear();
  }
}
