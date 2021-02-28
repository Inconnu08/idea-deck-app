import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea_deck/screens/signin.dart';

import '../button.dart';
import '../constants.dart';
import '../size_config.dart';

class IntroScreen extends StatelessWidget {
  static String routeName = "/intro";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // print("Screen");
    // print(SizeConfig.screenWidth * 0.1556);
    print(SizeConfig.imageSizeMultiplier * 50);
    print(Theme.of(context).textTheme.headline1.toString());
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/top.png",
                      height: SizeConfig.imageSizeMultiplier * 50,
                    ),
                  ),
                  SizedBox(height: 80),
                  Container(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.1556),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Idea Deck",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Watch adverstisements\nand win exciting prizes!",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "We will provide all the best offers\nstreaming in one click",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Join for free",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Center(
                    child: Container(
                      width: 200,
                      child: ThemeButton(
                        color: buttonColor,
                        text: "Connect",
                        ontap: () => Navigator.of(context)
                            .popAndPushNamed(SignInScreen.routeName),
                      ),
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
