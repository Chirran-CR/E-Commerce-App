import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/views/shared/stagger_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final male = snapshot.data;
          return GridView.builder(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 11,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: const [
                QuiltedGridTile(2, 1),
                QuiltedGridTile(2, 1),
                // QuiltedGridTile(2, 1),
                // QuiltedGridTile(1, 1),
              ],
            ),
            itemCount: male!.length,
            // shrinkWrap: true,
            // childrenDelegate:
            //     SliverChildBuilderDelegate((context, index) {
            itemBuilder: (context, index) {
              final shoe = snapshot.data![index];
              // print("vla of index is $index");
              // print(male.length);
              // return Padding(
              //   padding:
              //       const EdgeInsets.only(left: 8.0, right: 8),
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.amber,
              //     ),
              //   ),
              // );
              final bool showName = index % 2 == 0 ? true : false;
              return StaggerTile(
                name: shoe.name,
                price: shoe.price,
                imageUrl: shoe.imageUrl[1],
                showName: showName,
              );
            },

            // padding: EdgeInsets.zero,
            // crossAxisCount: 2,
            // crossAxisSpacing: 20,
            // mainAxisSpacing: 16,

            // itemCount: male!.length,
            // scrollDirection: Axis.horizontal,
            // itemBuilder: (context, index) {
            //   final shoe = snapshot.data![index];
            //   return Padding(
            //     padding:
            //         const EdgeInsets.only(left: 8.0, right: 8),
            //     child: ProductCard(
            //         name: shoe.name,
            //         category: shoe.category,
            //         price: "\$${shoe.price}",
            //         id: shoe.id,
            //         image: shoe.imageUrl[0]),
            //   );
            // },
          );
        }
      },
    );
  }
}
