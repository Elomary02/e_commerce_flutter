import 'package:ecommerce_app/views/shared/stagger_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/jackets_model.dart';

class LatestJackets extends StatelessWidget {
  final Future<List<Jacket>> type;
  const LatestJackets({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Jacket>>(
      future: type,
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapShot.hasError) {
          return Text("Error ${snapShot.error}.");
        } else {
          final jackets = snapShot.data!;
          return MasonryGridView.builder(
            gridDelegate:
            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: jackets.length,
            itemBuilder: (context, index) {
              final jacket = jackets[index];
              double tileHeight = (index % 2 == 0)
                  ? MediaQuery.of(context).size.height * 0.35
                  : MediaQuery.of(context).size.height * 0.3;
              return Container(
                height: tileHeight,
                child: StaggerTile(
                  name: jacket.name,
                  price: "\$${jacket.price}",
                  imageUrl: jacket.imageUrl[0],
                ),
              );
            },
          );
        }
      },
    );
  }
}
