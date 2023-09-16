import "package:e_commerce_app/models/sneaker_model.dart";
import "package:e_commerce_app/services/helper.dart";
import "package:e_commerce_app/views/shared/app_style.dart";
import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:flutter_vector_icons/flutter_vector_icons.dart";

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/top_image.png"),
                  fit: BoxFit.fill,
                ),
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
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle:
                        appStyleWithHt(16, Colors.white, FontWeight.bold, 0.1),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    labelPadding: const EdgeInsets.only(right: 12, top: 0),
                    // padding: const EdgeInsets.only(left: 1),
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: "Men Shoes"),
                      Tab(text: "Women Shoes"),
                      Tab(text: "Kid Shoes"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 16,
                right: 12,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder<List<Sneakers>>(
                    future: _male,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error ${snapshot.error}");
                      } else {
                        final male = snapshot.data;
                        return GridView.custom(
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 2,
                            repeatPattern: QuiltedGridRepeatPattern.same,
                            pattern: [
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(2, 1),
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(1, 1),
                            ],
                          ),
                          childrenDelegate:
                              SliverChildBuilderDelegate((context, index) {
                            final shoe = snapshot.data![index];
                            print("vla of index is $index");
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                ),
                              ),
                            );
                          }),

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
                  ),
                  Container(
                    height: 500,
                    width: 300,
                    color: Colors.green,
                  ),
                  Container(
                    height: 500,
                    width: 300,
                    color: Colors.green,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
