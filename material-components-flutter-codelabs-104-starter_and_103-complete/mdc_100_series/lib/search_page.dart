import 'package:flutter/material.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  List<Product> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _searchResults = _performSearch(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Cari Barang',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk melakukan pencarian
  List<Product> _performSearch(String query) {
    List<Product> results = [];
    final allProducts = ProductsRepository.loadProducts(Category.all);
    for (Product product in allProducts) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        results.add(product);
      }
    }
    return results;
  }
}
