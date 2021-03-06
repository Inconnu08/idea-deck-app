import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 130,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: getProportionateScreenWidth(1.5),
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: product.id.toString(),
                    child: Image.network(product.image),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Text(
                "\৳${product.price.toString()}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
