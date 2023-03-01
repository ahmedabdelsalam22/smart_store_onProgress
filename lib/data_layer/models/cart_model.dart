import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String id, productId;

  CartModel({
    required this.id,
    required this.productId,
  });
}
