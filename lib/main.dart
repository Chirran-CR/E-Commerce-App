import "package:e_commerce_app/controllers/main_screen_notifier.dart";
import "package:e_commerce_app/controllers/product_notifier.dart";
import "package:e_commerce_app/views/ui/main_screen.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:provider/provider.dart";

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  await Hive.openBox("cart_box");
  await Hive.openBox("fav_box");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
      ],
      child: const MyAppWidget(),
    ),
  );
}

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
