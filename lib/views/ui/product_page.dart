import "package:cached_network_image/cached_network_image.dart";
import "package:e_commerce_app/controllers/product_notifier.dart";
import "package:e_commerce_app/models/sneaker_model.dart";
import "package:e_commerce_app/services/helper.dart";
import "package:e_commerce_app/views/shared/app_style.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:flutter_vector_icons/flutter_vector_icons.dart";
import "package:provider/provider.dart";

class ProductPage extends StatefulWidget {
  final String id, category;

  const ProductPage({super.key, required this.id, required this.category});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  late Future<Sneakers> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFenaleSneakersById(widget.id);
    } else {
      _sneaker = Helper().getKidSneakersById(widget.id);
    }
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Sneakers>(
        future: _sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final sneaker = snapshot.data;
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
                              child: const Icon(
                                AntDesign.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: const Icon(
                                Ionicons.ellipsis_horizontal,
                                color: Colors.black,
                              ),
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
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        right: 20,
                                        child: const Icon(AntDesign.hearto,
                                            color: Colors.grey),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor: productNotifier
                                                            .activePage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
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
                                          sneaker.name,
                                          style: appStyle(35, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              sneaker.category,
                                              style: appStyle(20, Colors.grey,
                                                  FontWeight.w500),
                                            ),
                                            const SizedBox(width: 20),
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
                                                  const Icon(Icons.star,
                                                      size: 18,
                                                      color: Colors.black),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price}",
                                              style: appStyle(26, Colors.black,
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
                                                const SizedBox(width: 5),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                const SizedBox(width: 3),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
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
                                                const SizedBox(width: 20),
                                                Text(
                                                  "View size guide",
                                                  style: appStyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                itemCount: 3,
                                                scrollDirection: Axis.horizontal,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index){
                                                  return ChoiceChip(label: label, selected: selected)
                                                },
                                              ),
                                            ),
                                          ],
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
        },
      ),

      // CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       automaticallyImplyLeading: false,
      //       leadingWidth: 0,
      //       title: Padding(
      //         padding: const EdgeInsets.only(bottom: 10),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             GestureDetector(
      //               onTap: null,
      //               child: const Icon(AntDesign.close),
      //             ),
      //             GestureDetector(
      //               onTap: null,
      //               child: const Icon(Ionicons.ellipsis_horizontal),
      //             ),
      //           ],
      //         ),
      //       ),
      //       pinned: true,
      //       snap: false,
      //       floating: true,
      //       backgroundColor: Colors.transparent,
      //       expandedHeight: MediaQuery.of(context).size.height,
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: Stack(
      //           children: [
      //             SizedBox(
      //               height: MediaQuery.of(context).size.height * 0.5,
      //               width: MediaQuery.of(context).size.width,
      //               child: PageView.builder(
      //                 scrollDirection: Axis.horizontal,
      //                 itemCount: 4,
      //                 controller: pageController,
      //                 onPageChanged: (page) {},
      //                 itemBuilder: (context, index) {
      //                   return Stack(
      //                     children: [
      //                       Container(
      //                         height: MediaQuery.of(context).size.height * 0.39,
      //                         width: MediaQuery.of(context).size.width,
      //                         color: Colors.grey.shade300,
      //                         child: CachedNetworkImage(
      //                             imageUrl: imageUrl, fit: BoxFit.contain),
      //                       ),
      //                       Positioned(
      //                         top: MediaQuery.of(context).size.height * 0.09,
      //                         right: 20,
      //                         child: const Icon(AntDesign.hearto,
      //                             color: Colors.grey),
      //                       ),
      //                       Positioned(
      //                         bottom: 0,
      //                         right: 0,
      //                         left: 0,
      //                         height: MediaQuery.of(context).size.height * 0.3,
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: List<Widget>.generate(
      //                             length,
      //                             (index) => const Padding(
      //                               padding:
      //                                   EdgeInsets.symmetric(horizontal: 4),
      //                               child: CircleAvatar(
      //                                 radius: 5,
      //                                 backgroundColor: Colors.grey,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
