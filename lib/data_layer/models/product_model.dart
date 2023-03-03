import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id, title, imageUrl, productCategoryName, details;
  final double price, salePrice;
  final bool isOnSale;
  final int? rate;
  final bool? isDiscount;

  ProductModel({
    required this.isDiscount,
    this.rate = 3,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productCategoryName,
    required this.details,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'productCategoryName': productCategoryName,
      'details': details,
      'price': price,
      'salePrice': salePrice,
      'isDiscount': isDiscount,
      'isOnSale': isOnSale
    };
  }

  factory ProductModel.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    final data = map.data()!;

    return ProductModel(
      id: data['id'],
      title: data['title'],
      imageUrl: data['imageUrl'],
      productCategoryName: data['productCategoryName'],
      details: data['details'],
      price: double.parse(data['price']),
      salePrice: double.parse(data['salePrice']),
      isDiscount: data['isDiscount'],
      isOnSale: data['isOnSale'],
    );
  }
}
