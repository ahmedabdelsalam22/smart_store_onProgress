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
}
