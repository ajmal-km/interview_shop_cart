import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_shop_cart/model/product_model.dart';

class HomeController with ChangeNotifier {
  bool isLoading = false;
  bool isBottomLoading = false;
  bool isError = false;
  String message = '';
  List<ProductModel> products = [];
  String error = '';

  Future<void> fetchProducts() async {
    isLoading = true;
    isError = false;
    notifyListeners();
    try {
      final endpoint = "https://fakestoreapi.com/products";
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        products = productModelListFromJson(response.body);
      }
    } catch (e) {
      isError = true;
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct({
    required String title,
    required String description,
    required String price,
    required String category,
    required String ratings,
    required String ratingCount,
  }) async {
    isBottomLoading = true;
    isError = false;
    notifyListeners();
    final newProduct = ProductModel(
        title: title,
        price: double.parse(price),
        description: description,
        category: category,
        rating: Rating(
          rate: double.parse(ratings),
          count: int.parse(ratingCount),
        ));

    try {
      final endpoint = "https://fakestoreapi.com/products";
      var response = await http.post(
        Uri.parse(endpoint),
        // 1st method :
        body: productModelToJson(newProduct),
        // 2nd method :
        // body: {
        //     "title": title,
        //     "price": price,
        //     "description": description,
        //     "category": category,
        //     "rating": {"rate": ratings, "count": ratingCount}
        //   }
      );
      log(response.reasonPhrase.toString());
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        message = "Product added cuccessfully";
      }
    } catch (e) {
      isError = true;
      error = e.toString();
    }
    isBottomLoading = false;
    notifyListeners();
  }
}
