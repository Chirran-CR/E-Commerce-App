import "package:e_commerce_app/controllers/main_screen_notifier.dart";
import "package:e_commerce_app/views/ui/main_screen.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),

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
