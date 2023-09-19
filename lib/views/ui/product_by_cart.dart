import "dart:collection";

import "package:e_commerce_app/models/sneaker_model.dart";
import "package:e_commerce_app/services/helper.dart";
import "package:e_commerce_app/views/shared/app_style.dart";
import "package:e_commerce_app/views/shared/category_btn.dart";
import "package:e_commerce_app/views/shared/custom_spacer.dart";
import "package:e_commerce_app/views/shared/latest_shoes.dart";
import "package:e_commerce_app/views/shared/stagger_tile.dart";
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

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

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
                            // Navigator.pop(context);
                            filter();
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
                  LatestShoes(male: _male),
                  LatestShoes(male: _female),
                  LatestShoes(male: _kids),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Modal Bottom Sheet

  Future<dynamic> filter() {
    double _value = 100; //for price
    // print("val of context is: $context");
    // print("context height is : ${MediaQuery.of(context).size.height}");

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white54,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.82,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  Container(
                    height: 4,
                    width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      children: [
                        const CustomSpacer(),
                        Text(
                          "Filter",
                          style: appStyle(35, Colors.black, FontWeight.bold),
                        ),
                        const CustomSpacer(),
                        Text(
                          "Gender",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CategoryBtn(
                              buttonClr: Colors.black,
                              label: "Men",
                            ),
                            CategoryBtn(
                              buttonClr: Colors.grey,
                              label: "Women",
                            ),
                            CategoryBtn(
                              buttonClr: Colors.grey,
                              label: "Kids",
                            ),
                          ],
                        ),
                        const CustomSpacer(),
                        Text(
                          "Category",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            CategoryBtn(
                              buttonClr: Colors.black,
                              label: "Shoes",
                            ),
                            CategoryBtn(
                              buttonClr: Colors.grey,
                              label: "Apparrels",
                            ),
                            CategoryBtn(
                              buttonClr: Colors.grey,
                              label: "Accessories",
                            ),
                          ],
                        ),
                        const CustomSpacer(),
                        Text(
                          "Price",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        Slider(
                          value: _value,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey,
                          thumbColor: Colors.black,
                          max: 500,
                          divisions: 50,
                          label: _value.toString(),
                          // secondaryActiveColor: Colors.amber,
                          secondaryTrackValue: 200,
                          onChanged: (double newVal) {
                            print("val of newVal is: $newVal");
                          },
                        ),
                        // const CustomSpacer(),
                        const SizedBox(height: 10),
                        Text(
                          "Brand",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: brand.length,
                              itemExtent: 95,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    child: Image.asset(brand[index]),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
