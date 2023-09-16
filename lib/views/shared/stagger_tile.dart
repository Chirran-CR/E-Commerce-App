import "package:cached_network_image/cached_network_image.dart";
import "package:e_commerce_app/models/sneaker_model.dart";
import "package:e_commerce_app/services/helper.dart";
import "package:e_commerce_app/views/shared/app_style.dart";
import "package:flutter/material.dart";

class StaggerTile extends StatefulWidget{
  
  final String imageUrl, name, price;
  const StaggerTile({super.key, required this.name, required this.price, required this.imageUrl});

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {



  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child:  Padding(
        padding: const  EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl, fit:BoxFit.fill),
            Container(
              padding: const EdgeInsets.only(top:12),
              height: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: appStyleWithHt(20, Colors.black, FontWeight.w700,1)),
                  Text(widget.price, style: appStyleWithHt(20, Colors.black, FontWeight.w500,1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}