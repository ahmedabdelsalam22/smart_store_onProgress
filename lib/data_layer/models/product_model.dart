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
/*
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'productCategoryName': productCategoryName,
      'details': details,
      'price': price,
      'salePrice': salePrice,
      'rate': rate,
      'isDiscount': isDiscount,
      'isOnSale': isOnSale
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt(),
      title: map['title'],
      imageUrl: map['imageUrl'],
      productCategoryName: map['productCategoryName'],
      details: map['details'],
      price: double.parse(map['price']),
      salePrice: double.parse(map['salePrice']),
      rate: map['rate'],
      isDiscount: map['isDiscount'],
      isOnSale: map['isOnSale'],
    );
  }*/
}
