

import 'package:flutter_assignment/models/product.dart';

class ProductResponse {
  List<Product> products;
  int total;
  int skip;
  int limit;

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  ProductResponse copyWith({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  }) =>
      ProductResponse(
        products: products ?? this.products,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}