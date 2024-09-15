import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/product.dart';
import 'package:rest_api/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 5, // Adds shadow to the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          product.image ?? '',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title ?? 'No Title',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              product.description ?? 'No Description',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  '${product.rating?.rate ?? 'N/A'} stars',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  '(${product.rating?.count ?? 0} reviews)',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }
}





