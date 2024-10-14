import 'package:ecommerce_app/controllers/product_provider.dart';
import 'package:ecommerce_app/views/shared/product_card.dart';
import 'package:ecommerce_app/views/ui/product_by_cart.dart';
import 'package:ecommerce_app/views/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/jackets_model.dart';
import 'app_style.dart';
import 'new_jackets.dart';

class HomeWidget extends StatelessWidget {
  final int tabIndex;
  final Future<List<Jacket>> type;

  const HomeWidget({super.key, required this.type, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder<List<Jacket>>(
              future: type,
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapShot.hasError) {
                  return Text("Error ${snapShot.error}.");
                } else {
                  final male = snapShot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final jacket = snapShot.data![index];
                        return GestureDetector(
                          onTap: () {
                            productNotifier.jacketSizes = jacket.sizes;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(id: jacket.id, category: jacket.category),
                                ),
                            );
                          },
                          child: ProductCard(
                              id: jacket.id,
                              name: jacket.name,
                              category: jacket.category,
                              price: "\$${jacket.price}",
                              image: jacket.imageUrl[0]
                          ),
                        );
                      }
                  );
                }
              }
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Jackets",
                    style: appStyle(
                        24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductByCart(tabIndex: tabIndex,),
                          ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appStyle(
                              22, Colors.black, FontWeight.w500),
                        ),
                        const Icon(
                          Icons.arrow_right,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: FutureBuilder<List<Jacket>>(
              future: type,
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapShot.hasError) {
                  return Text("Error ${snapShot.error}.");
                } else {
                  final male = snapShot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final jacket = male[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewJackets(
                              imageUrl: jacket.imageUrl[1]
                          ),
                        );
                      }
                  );
                }
              }
          ),
        ),
      ],
    );
  }
}
