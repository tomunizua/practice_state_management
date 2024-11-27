import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites.dart';
import 'favorites_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Favorites(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorites App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'name': 'White Cupcakes', 'image': 'assets/product1.jpg'},
    {'name': 'Blue Cupcakes', 'image': 'assets/product2.jpg'},
    {'name': 'Pink Cupcakes', 'image': 'assets/product3.jpg'},
    {'name': 'Brown Cupcakes', 'image': 'assets/product4.jpg'},
    {'name': 'Green Cupcakes', 'image': 'assets/product5.jpg'},
    {'name': 'Monochrome Cupcakes', 'image': 'assets/product6.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final productName = product['name'] ?? 'Unknown Product';
          final isFavorite = Provider.of<Favorites>(context).items.contains(productName);

          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  product['image'] ?? '',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            Provider.of<Favorites>(context, listen: false).removeItem(productName);
                          } else {
                            Provider.of<Favorites>(context, listen: false).addItem(productName);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen(products: products)),
          );
        },
      ),
    );
  }
}
