import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_shop_cart/model/product_model.dart';

class ProductController with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  ProductModel? product;
  String error = '';
  var pickedImageUrl;

  Future<void> fetchProduct(String id) async {
    isLoading = true;
    isError = false;
    notifyListeners();
    try {
      final endpoint = "https://fakestoreapi.com/products/$id";
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        product = productModelFromJson(response.body);
      }
    } catch (e) {
      isError = true;
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
