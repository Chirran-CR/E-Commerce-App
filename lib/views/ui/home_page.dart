import "package:e_commerce_app/views/shared/app_style.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "This is Home",
          style: appStyle(40, Colors.black, FontWeight.bold),
        ),
      ),
    );
  }
}
