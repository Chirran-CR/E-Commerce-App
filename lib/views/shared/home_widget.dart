import 'package:e_commerce_app/controllers/product_notifier.dart';
import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/views/shared/app_style.dart';
import 'package:e_commerce_app/views/shared/new_shoes.dart';
import 'package:e_commerce_app/views/shared/product_card.dart';
import 'package:e_commerce_app/views/ui/product_by_cart.dart';
import 'package:e_commerce_app/views/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabIdx,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  final int tabIdx;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: GestureDetector(
                        onTap: () {
                          productNotifier.shoeSizes = shoe.sizes;
                          print("val of productNotifier.shoeSizes is: ${productNotifier.shoeSizes}");
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                    id: shoe.id, category: shoe.category),
                              ));
                        },
                        child: ProductCard(
                            name: shoe.name,
                            category: shoe.category,
                            price: "\$${shoe.price}",
                            id: shoe.id,
                            image: shoe.imageUrl[0]),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appStyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductByCart(tabIndex: tabIdx)),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appStyle(22, Colors.black, FontWeight.w500),
                        ),
                        const Icon(AntDesign.caretright, size: 20)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: NewShoes(imageUrl: shoe.imageUrl[1]),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
