import 'package:ecommerce_app/controllers/cart_provider.dart';
import 'package:ecommerce_app/views/shared/checkout_btn.dart';
import 'package:ecommerce_app/views/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/views/shared/app_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {

  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartNotifier>(context, listen: true);
    cartProvider.getCart();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: const Icon(
                    Ionicons.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appStyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.65,
                  child: ListView.builder(
                    itemCount: cartProvider.cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cartProvider.cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 1,
                                      onPressed: (context) {
                                        cartProvider.deleteCart(data["key"]);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => MainScreen())
                                        );
                                      },
                                      backgroundColor: const Color(0xFF000000),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: "Delete",
                                    ),
                                  ],
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade500,
                                      spreadRadius: 5,
                                      blurRadius: 0.3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Image.asset(
                                            data["imageUrl"],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12, left: 20,),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(data["name"], style: appStyle(16, Colors.black, FontWeight.bold),),
                                              const SizedBox(height: 5,),
                                              Text(data["category"], style: appStyle(14, Colors.grey, FontWeight.w600),),
                                              const SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Text("\$${data["price"]}", style: appStyle(18, Colors.black, FontWeight.w600),),
                                                  const SizedBox(width: 40,),
                                                  Text("Size", style: appStyle(18, Colors.grey, FontWeight.w600),),
                                                  const SizedBox(width: 15,),
                                                  Column(
                                                    children: (data["sizes"] as List<dynamic>).map((size) {
                                                      return Row(
                                                        children: [
                                                          Text(
                                                            overflow: TextOverflow.fade,
                                                            "$size",
                                                            style: appStyle(18, Colors.grey, FontWeight.w600),
                                                          ),
                                                        ],
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(16)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: cartProvider.decrement,
                                                  child: const Icon(
                                                      Ionicons.remove_circle,
                                                    size: 20,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                    data["qty"].toString(),
                                                  style: appStyle(16, Colors.black, FontWeight.w600),
                                                ),
                                                InkWell(
                                                  onTap: cartProvider.increment,
                                                  child: const Icon(
                                                    Ionicons.add_circle,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutBtn(label: "Proceed to checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
