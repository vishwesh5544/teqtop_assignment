import 'package:flutter_assignment/models/product.dart';

abstract class BaseState {}

class InitialState extends BaseState {}

class ProductsLoading extends BaseState {}

class ProductsLoaded extends BaseState {
  final List<Product> products;
  final bool isDataFound;

  ProductsLoaded({required this.products, required this.isDataFound});
}

class ProductsError extends BaseState {
  final String message;

  ProductsError({required this.message});
}
