import 'package:ecommerce_app/controllers/product_provider.dart';
import 'package:ecommerce_app/views/shared/app_style.dart';
import 'package:ecommerce_app/views/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../models/jackets_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final productNotifier = Provider.of<ProductNotifier>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        title: TextField(
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
          decoration: InputDecoration(
            suffixIcon: const Icon(Ionicons.search),
            hintText: 'Search products...',
            hintStyle: appStyle(18, Colors.grey, FontWeight.w600),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.black38,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFE2E2E2),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          ),
        ),
      ),
      body: FutureBuilder<List<Jacket>>(
        future: productNotifier.searchProducts(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: appStyle(16, Colors.black38, FontWeight.w900),));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found!', style: appStyle(16, Colors.black38, FontWeight.w900),));
          } else {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final jacket = results[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        jacket.imageUrl[0],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jacket.name,
                              style: appStyle(20, Colors.black, FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${jacket.price}',
                              style: appStyle(20, Colors.black, FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(id: jacket.id, category: jacket.category)));
                        },
                        child: const Icon(Ionicons.arrow_forward_circle),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
