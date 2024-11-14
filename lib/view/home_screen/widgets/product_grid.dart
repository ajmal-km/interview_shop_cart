import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.onProductTap,
  });

  final String image;
  final String title;
  final String price;
  final void Function()? onProductTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProductTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 190,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              image: image.isEmpty ? null : DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.contain,
              ),
            ),
            child: image.isEmpty ? Icon(
              Icons.image,
              size: 60,
              color: Colors.black54,
            ) : null,
          ),
          SizedBox(height: 8),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            price,
            style: TextStyle(
              color: Colors.green,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
