import 'dart:convert';

import 'package:flutter_assignment/models/api_response.dart';
import 'package:flutter_assignment/models/product_response.dart';
import 'package:http/http.dart' as http;

class BaseService implements IBaseService {
  final String _baseUrl = "https://dummyjson.com/products";

  @override
  Future<ApiResponse<ProductResponse>> getAllDummyData() async {
    try {
      final uri = Uri.parse(_baseUrl);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final productResponse = ProductResponse.fromJson(json);
        return ApiResponse<ProductResponse>(
            data: productResponse, success: true, message: 'Products fetched successfully.');
      } else {
        return ApiResponse<ProductResponse>(message: "Unknown error occurred while fetching products.", success: false);
      }
    } on http.ClientException catch (e) {
      return ApiResponse<ProductResponse>(message: e.message, success: false);
    } catch (e) {
      return ApiResponse<ProductResponse>(message: e.toString(), success: false);
    }
  }
}

abstract class IBaseService {
  Future<ApiResponse<ProductResponse>> getAllDummyData();
}
