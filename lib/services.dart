import 'package:rest_api/product.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
class ProductService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}