import "package:e_commerce_app/views/shared/app_style.dart";
import "package:flutter/material.dart";
import "package:flutter_vector_icons/flutter_vector_icons.dart";

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.category,
      required this.price,
      required this.id,
      required this.image});

  final String name, category, price, id, image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 0.6,
                  offset: Offset(1, 1)),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: null,
                      child: const Icon(MaterialCommunityIcons.heart_outline),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style:
                          appStyleWithHt(26, Colors.black, FontWeight.bold, 1),
                    ),
                    Text(
                      widget.category,
                      style:
                          appStyleWithHt(15, Colors.grey, FontWeight.bold, 1.2),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appStyle(13, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          "Colors",
                          style: appStyle(13, Colors.grey, FontWeight.w500),
                        ),
                        // const SizedBox(width: 1),
                        ChoiceChip(
                          label: const Text(" "),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                          shape: OutlinedBorder.lerp(
                              const CircleBorder(),
                              const CircleBorder(),
                              BorderSide.strokeAlignCenter),
                          // side: BorderSide(width: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
