import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea_deck/models/ads.dart';

import '../button.dart';
import '../constants.dart';
import '../screens/reset_password.dart';
import '../screens/signup.dart';
import '../size_config.dart';

class VideoDetailScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  _VideoDetailScreenState createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // print("Screen");
    // print(SizeConfig.screenWidth * 0.1556);
    print(SizeConfig.imageSizeMultiplier * 50);
    print(Theme.of(context).textTheme.headline1.toString());
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
                    args.ad.title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: kPrimaryColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Idea Deck",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: kPrimaryColor),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Enter the following details to log in to your account or ",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "create an account ᐳ",
                          style:
                              Theme.of(context).textTheme.headline5.copyWith(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context)
                                .pushNamed(SignUpScreen.routeName),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.1556),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, ResetPasswordScreen.routeName),
                                  customBorder: StadiumBorder(),
                                  child: Text(
                                    "Forgot Password?",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      width: 200,
                      child: ThemeButton(
                        color: buttonColor,
                        text: "Connect",
                        ontap: () => 1,
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

class ScreenArguments {
  final Advertisement ad;

  ScreenArguments(this.ad);
}
