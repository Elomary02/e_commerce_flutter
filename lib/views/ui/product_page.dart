import 'package:ecommerce_app/controllers/cart_provider.dart';
import 'package:ecommerce_app/controllers/favorites_provider.dart';
import 'package:ecommerce_app/controllers/product_provider.dart';
import 'package:ecommerce_app/views/shared/app_style.dart';
import 'package:ecommerce_app/views/shared/checkout_btn.dart';
import 'package:ecommerce_app/views/ui/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../models/jackets_model.dart';

class ProductPage extends StatefulWidget {
  final String id;
  final String category;

  const ProductPage({super.key, required this.id, required this.category});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();

    var productNotifier = Provider.of<ProductNotifier>(context, listen: true);
    productNotifier.getJackets(widget.id, widget.category);

    var cartNotifier = Provider.of<CartNotifier>(context, listen: true);

    return Scaffold(
      body: FutureBuilder<Jacket>(
          future: productNotifier.jacket,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapShot.hasError) {
              return Text("Error ${snapShot.error}.");
            } else {
              final jacket = snapShot.data;
              return Consumer<ProductNotifier>(
                builder: (context, productNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Ionicons.close_sharp),
                              ),
                              GestureDetector(
                                onTap: null,
                                child: const Icon(Ionicons.ellipsis_horizontal),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: jacket!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.39,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey.shade300,
                                          child: Padding(
                                            padding: const EdgeInsets.all(50),
                                            child: Image.asset(
                                              jacket.imageUrl[0],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          right: 20,
                                          child: Consumer<FavoritesNotifier>(
                                              builder: (context, favoriteNotifier, child) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (favoriteNotifier.ids.contains(widget.id)) {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage()));
                                                    } else {
                                                      favoritesNotifier.createFav({
                                                        "id" : jacket.id,
                                                        "name" : jacket.name,
                                                        "category" : jacket.category,
                                                        "price" : jacket.price,
                                                        "imageUrl" : jacket.imageUrl[0]
                                                      });
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: favoriteNotifier.ids.contains(jacket.id) ? const Icon(Ionicons.heart) : const Icon(Ionicons.heart_outline),
                                                );
                                              }
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List<Widget>.generate(
                                                jacket.imageUrl.length,
                                                (index) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor:
                                                        productNotifier
                                                                    .activePage !=
                                                                index
                                                            ? Colors.grey
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.645,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${jacket.name} Jacket",
                                            style: appStyle(40, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                jacket.category,
                                                style: appStyle(20, Colors.grey,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Ionicons.star,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${jacket.price}",
                                                style: appStyle(
                                                    26,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Colors",
                                                    style: appStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.lightGreen,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Select sizes",
                                                    style: appStyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "View size guide",
                                                    style: appStyle(
                                                        20,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                    itemCount: productNotifier
                                                        .jacketSizes.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final sizes =
                                                          productNotifier
                                                                  .jacketSizes[
                                                              index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: ChoiceChip(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            side:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid,
                                                            ),
                                                          ),
                                                          disabledColor:
                                                              Colors.white,
                                                          label: Text(
                                                            sizes["size"],
                                                            style: appStyle(
                                                                18,
                                                                sizes["isSelected"]
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          showCheckmark: false,
                                                          selected: sizes[
                                                              "isSelected"],
                                                          selectedColor:
                                                              Colors.black,
                                                          onSelected:
                                                              (newState) {
                                                            if(productNotifier.sizes.contains(sizes['size'])) {
                                                              productNotifier.sizes.remove(sizes["size"]);
                                                            } else {
                                                              productNotifier.sizes.add(sizes["size"]);
                                                            }
                                                            productNotifier
                                                                .toggleCheck(
                                                                    index);
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              jacket.title,
                                              style: appStyle(26, Colors.black,
                                                  FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            jacket.description,
                                            textAlign: TextAlign.justify,
                                            style: appStyle(14, Colors.grey,
                                                FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: CheckoutBtn(
                                                label: "Add to cart",
                                                onTap: () async {
                                                  cartNotifier.createCart(
                                                    {
                                                      "id" : jacket.id,
                                                      "name" : jacket.name,
                                                      "category" : jacket.category,
                                                      "sizes" : productNotifier.sizes,
                                                      "imageUrl" : jacket.imageUrl[0],
                                                      "price" : jacket.price,
                                                      "qty" : 1
                                                    }
                                                  );
                                                  productNotifier.sizes.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
