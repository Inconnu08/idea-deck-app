import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../models/product.dart';
import '../size_config.dart';
import '../widgets/product_card.dart';

class ProductsSuggestionsScreen extends StatelessWidget {
  static String routeName = "/product-suggestions";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var p = [
      Product(
          id: 1,
          name: "Cheez Pizza",
          price: 120,
          image:
              "https://static.toiimg.com/thumb/53110049.cms?width=1200&height=900"),
      Product(
          id: 1,
          name: "Cheez Juice",
          price: 20,
          image:
              "https://cdn.chaldal.net/_mpimage/cyprina-grape-juice-1-ltr?src=https%3A%2F%2Feggyolk.chaldal.com%2Fapi%2FPicture%2FRaw%3FpictureId%3D16872&q=low&v=1"),
    ];

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Thank you!",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: kPrimaryColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Here are some suggested products and other offers you might be interested in.",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Container(
                    height: getProportionateScreenHeight(250),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: p.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(product: p[index]);
                      },
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
