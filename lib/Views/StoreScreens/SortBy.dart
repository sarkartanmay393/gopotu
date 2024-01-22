import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedSortOption;
  List<Product> products = [
    Product(name: 'Product A', price: 20.0),
    Product(name: 'Product B', price: 15.0),
    Product(name: 'Product C', price: 25.0),
    // Add more products as needed
  ];

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sort By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Low to High'),
                leading: Radio(
                  value: 'low_to_high',
                  groupValue: selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value as String?;
                      _sortProducts();
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('High to Low'),
                leading: Radio(
                  value: 'high_to_low',
                  groupValue: selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value as String?;
                      _sortProducts();
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              // Add more sorting options as needed
            ],
          ),
        );
      },
    );
  }

  void _sortProducts() {
    if (selectedSortOption == 'low_to_high') {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSortOption == 'high_to_low') {
      products.sort((a, b) => b.price.compareTo(a.price));
    }
    // Add more sorting options as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _showSortOptions,
            child: Text('Sort Options'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].name),
                  subtitle: Text('Price: \$${products[index].price.toString()}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}