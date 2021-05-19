import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';
import '../size_config.dart';
import '../widgets/product_card.dart';

class ProductsSuggestionsScreen extends StatelessWidget {
  static String routeName = "/product-suggestions";

  @override
  Widget build(BuildContext context) {
    /// THIS SCREEN IS NOT USED AND SHOULD BE DELETED. 

    var p = [
      Product(
          id: 1,
          name: "Cheez Pizza",
          price: 120,
          image:
              "https://static.toiimg.com/thumb/53110049.cms?width=1200&height=900",
          url: "https://www.facebook.com/cheezbd/"),
      Product(
          id: 5,
          name: "Cheez Juice",
          price: 20,
          image:
              "https://i.pinimg.com/originals/7d/ab/9d/7dab9d75b959d2fd74d7bae9bc7f8b18.jpg",
          url: "https://www.facebook.com/cheezbd/"),
      Product(
          id: 3,
          name: "Cheez T Shirt",
          price: 220,
          image:
              "https://cdn.shopify.com/s/files/1/0209/1522/products/party_pizza_tee_preview_1024x1024.jpg?v=1590534250",
          url: "https://www.facebook.com/cheezbd/"),
      Product(
          id: 4,
          name: "Cheez Mask",
          price: 100,
          image:
              "https://trickortreatstudios.com/media/catalog/product/cache/1da4909b8e3ea5eea17a9fb4c6e4a516/p/i/pizza_fiend_1.png"),
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
                        return ProductCard();
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
