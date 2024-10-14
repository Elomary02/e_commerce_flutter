import 'package:ecommerce_app/views/shared/category_btn.dart';
import 'package:ecommerce_app/views/shared/custom_spacer.dart';
import 'package:ecommerce_app/views/shared/latest_jackets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_provider.dart';
import '../shared/app_style.dart';

class ProductByCart extends StatefulWidget {
  final int tabIndex;

  const ProductByCart({super.key, required this.tabIndex});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context, listen: true);
    productNotifier.getMen();
    productNotifier.getWomen();
    productNotifier.getKids();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/wave_img.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Ionicons.close_sharp,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesomeIcons.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.white.withOpacity(0.7),
                    tabs: const [
                      Tab(text: "Men jackets"),
                      Tab(text: "Women jackets"),
                      Tab(text: "Kids jackets"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestJackets(type: productNotifier.men),
                  LatestJackets(type: productNotifier.women),
                  LatestJackets(type: productNotifier.kids),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.82,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 5,
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    const CustomSpacer(),
                    Text(
                      "Filter",
                      style: appStyle(40, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Text(
                      "Gender",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        CategoryBtn(
                          btnClr: Colors.black,
                          label: "Men",
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Women",
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Kids",
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Category",
                      style: appStyle(20, Colors.black, FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        CategoryBtn(
                          btnClr: Colors.black,
                          label: "Casual",
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Sport",
                        ),
                        CategoryBtn(
                          btnClr: Colors.grey,
                          label: "Formal",
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Price",
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Slider(
                        value: value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value) {}
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
