import "package:e_commerce_app/controllers/main_screen_notifier.dart";
import "package:e_commerce_app/views/shared/app_style.dart";
import "package:e_commerce_app/views/shared/bottom_nav_bar.dart";
// import "package:e_commerce_app/views/shared/bottom_nav_widget.dart";
import "package:e_commerce_app/views/ui/cart_page.dart";
import "package:e_commerce_app/views/ui/home_page.dart";
import "package:e_commerce_app/views/ui/product_by_cart.dart";
import "package:e_commerce_app/views/ui/profile_page.dart";
import "package:e_commerce_app/views/ui/search_page.dart";
import "package:flutter/material.dart";
// import "package:ionicons/ionicons.dart";
import "package:provider/provider.dart";

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const HomePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}






// Scaffold(
//         backgroundColor: const Color(0xFFE2E2E2),
//         body: pageList[pageIndex],
//         bottomNavigationBar: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   BottomNavWidget(onTap: () {}, icon: Ionicons.home),
//                   BottomNavWidget(onTap: () {}, icon: Ionicons.search),
//                   BottomNavWidget(onTap: () {}, icon: Ionicons.add),
//                   BottomNavWidget(onTap: () {}, icon: Ionicons.cart),
//                   BottomNavWidget(onTap: () {}, icon: Ionicons.person),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
// class BottomNavWidget extends StatelessWidget {
//   const BottomNavWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: const SizedBox(
//         height: 36,
//         width: 36,
//         child: Icon(
//           Ionicons.home,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
