import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api/product.dart';
  // Import your Product and Products classes

class ApiService {
  final String _baseUrl = 'https://dummyjson.com/products';

  Future<Product> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Product.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
