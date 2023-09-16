// import "package:cached_network_image/cached_network_image.dart";
import "package:e_commerce_app/models/sneaker_model.dart";
import "package:e_commerce_app/services/helper.dart";
import "package:e_commerce_app/views/shared/app_style.dart";
import "package:e_commerce_app/views/shared/home_widget.dart";
// import "package:e_commerce_app/views/shared/new_shoes.dart";
// import "package:e_commerce_app/views/shared/product_card.dart";
import "package:flutter/material.dart";
// import "package:flutter_vector_icons/flutter_vector_icons.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
              child: Container(
                padding: const EdgeInsets.only(left: 2, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Athletics Shoes",
                      style: appStyleWithHt(
                          32, Colors.white, FontWeight.bold, 1.5),
                    ),
                    Text(
                      "Collection",
                      style: appStyleWithHt(
                          32, Colors.white, FontWeight.bold, 1.5),
                    ),
                    TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyleWithHt(
                          16, Colors.white, FontWeight.bold, 0.1),
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
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(male: _male),
                    HomeWidget(male: _female),
                    HomeWidget(male: _kids),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
