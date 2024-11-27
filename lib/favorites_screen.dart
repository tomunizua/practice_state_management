import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> products;

  FavoritesScreen({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (context, favorites, child) {
          return ListView.builder(
            itemCount: favorites.items.length,
            itemBuilder: (context, index) {
              final itemName = favorites.items[index];
              final product = products.firstWhere(
                (product) => product['name'] == itemName,
                orElse: () => {'name': itemName, 'image': ''},
              );

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product['image']!.isNotEmpty)
                      Image.asset(
                        product['image']!,
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
                            itemName,
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              favorites.removeItem(itemName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
