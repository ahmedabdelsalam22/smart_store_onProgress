import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'firebase_constance.dart';

class GlobalMethod {
  // add product to firebase cart
  static Future<void> addToCart({
    required String productId,
  }) async {
    final User? user = FireBaseConstance.currentUser;
    final uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
          }
        ])
      });
    } catch (error) {}
  }
}
