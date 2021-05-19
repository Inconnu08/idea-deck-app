import 'package:flutter/material.dart';
import 'package:idea_deck/network/http.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../models/questions.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 130,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final SuggestedProduct product;

  void _launchURL() async => await canLaunch(product.link)
      ? await launch(product.link)
      : throw 'Could not launch ${product.link}';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => _launchURL(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: getProportionateScreenWidth(0.9),
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: product.id.toString(),
                    child: Image.network('${domain}${product.image}'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              // Text(
              //   "\৳${product.price.toString()}",
              //   style: TextStyle(
              //     fontSize: getProportionateScreenWidth(18),
              //     fontWeight: FontWeight.w600,
              //     color: kPrimaryColor,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
