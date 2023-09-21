import 'package:e_commerce_app/views/shared/app_style.dart';
import 'package:flutter/material.dart';

class CheckoutBtn extends StatelessWidget {
  final void Function()? onTap;
  final String label;

  const CheckoutBtn({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
              child: Text(label,
                  style: appStyle(20, Colors.white, FontWeight.bold))),
        ),
      ),
    );
  }
}
