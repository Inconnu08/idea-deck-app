import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../button.dart';
import '../constants.dart';
import '../size_config.dart';
import '../screens/suggest.dart';

class SurveyScreen extends StatefulWidget {
  static String routeName = "/survey";

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  var formValues = {};

  // @override
  // void initState() {
  //   SystemChrome.setSystemUIOverlayStyle(
  //       SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
  //   super.initState();
  // }

  void _saveForm() async {
    setState(() {
      _loading = true;
    });

    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      setState(() {
        _loading = false;
      });
      return;
    }

    // _formKey.currentState.save();

    // try {
    //   var r = await login(email, password);

    //   print('body: ${r.body}');
    //   var b = json.decode(r.body);
    //   var s = r.statusCode;
    //   print('status code s: $s');
    //   print('status code direct: ${r.statusCode}');

    //   if (s != 200) {
    //     if (s == 402) {
    //       sharedPrefs.token = b['token'];
    //       var p = b['profile'];
    //       print(p);
    //       print(b);
    //       print(p['full_name']);
    //       print(b['email']);
    //       print(b['id']);
    //       sharedPrefs.uid = b['id'];
    //       sharedPrefs.isGuest = false;
    //       sharedPrefs.name = p['full_name'];
    //       sharedPrefs.phone = p['phone'];
    //       sharedPrefs.email = b['email'];
    //       sharedPrefs.isSeller = b['is_seller'];
    //       if (b['is_seller']) {
    //         sharedPrefs.shopName = p['shop_name'];
    //         sharedPrefs.shopPicture = p['shop_picture'];
    //         sharedPrefs.address = p['address'];
    //         sharedPrefs.city = p['city'];
    //       } else {
    //         sharedPrefs.address = p['address'];
    //         sharedPrefs.city = p['city'];
    //       }

    //       sharedPrefs.a = b['a'];
    //       sharedPrefs.subscriptionEnd = p['subscription_end'];
    //       sharedPrefs.subscriptionStart = p['subscription_start'];
    //       sharedPrefs.tradeLicense = p['trade_license'];
    //       sharedPrefs.firstLaunch = false;
    //       Fluttertoast.showToast(
    //           msg: b['message'],
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.red,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //       Navigator.of(context).pop();
    //       if (p['referral'] != null) {
    //         print("===============================>${p['referral']})");
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => PaymentOptionsScreen(true)),
    //         );
    //         return;
    //       }
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => PaymentOptionsScreen(false)),
    //       );
    //     }
    //     if (s == 400) addError(error: "Incorrect email or password");
    //     setState(() {
    //       _loading = false;
    //     });
    //     return;
    //   }
    //   var p = b['profile'];
    //   print(p);
    //   print(b);
    //   print(p['full_name']);
    //   print(b['email']);
    //   print(b['id']);
    //   sharedPrefs.uid = b['id'];
    //   sharedPrefs.name = p['full_name'];
    //   sharedPrefs.phone = p['phone'];
    //   sharedPrefs.email = b['email'];
    //   sharedPrefs.token = b['token'];
    //   sharedPrefs.isSeller = b['is_seller'];
    //   sharedPrefs.isGuest = false;
    //   if (b['is_seller']) {
    //     sharedPrefs.shopName = p['shop_name'];
    //     sharedPrefs.shopPicture = p['shop_picture'];
    //     sharedPrefs.address = p['address'];
    //     sharedPrefs.city = p['city'];
    //   } else {
    //     sharedPrefs.address = p['address'];
    //     sharedPrefs.city = p['city'];
    //   }

    //   sharedPrefs.a = b['a'];
    //   sharedPrefs.subscriptionEnd = p['subscription_end'];
    //   sharedPrefs.subscriptionStart = p['subscription_start'];
    //   sharedPrefs.tradeLicense = p['trade_license'];
    //   sharedPrefs.firstLaunch = false;
    //   // storeAuth(context, r.body);

    //   Navigator.popAndPushNamed(context, LoginSuccessScreen.routeName);
    // } on SocketException catch (e) {
    //   print("Socket Exception: $e");
    //   setState(() {
    //     _loading = false;
    //   });
    Fluttertoast.showToast(
        msg: "No internet connection!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    // }
  }

  @override
  Widget build(BuildContext context) {
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
                    "Survey",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: kPrimaryColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Although the survey is completely optional, completing will earn you another entry to the draw!",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.grey),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.1556),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Who was that tall looking monkey?"),
                              buildInputFormField(1),
                              SizedBox(
                                  height: getProportionateScreenHeight(30)),
                              Text(
                                  "Do have any option to make you own pizza and come to our shop to sell it like a pro? Let us know details in a few words."),
                              buildInputFormField(2),
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  _loading
                      ? Center(
                          child: JumpingDotsProgressIndicator(
                          fontSize: 60.0,
                          color: kPrimaryColor,
                        ))
                      : Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            width: 200,
                            child: ThemeButton(
                              color: buttonColor,
                              text: "Submit",
                              ontap: () => Navigator.pushNamed(
                            context, ProductsSuggestionsScreen.routeName),
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

  TextFormField buildInputFormField(int id) {
    return TextFormField(
      minLines: 3,
      maxLines: 4,
      keyboardType: TextInputType.text,
      // validator: (value) => validateMobile(value),
      onSaved: (newValue) => formValues[id] = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          // removeError(error: kInvalidEmailError);
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        labelText: "",
        labelStyle: const TextStyle(color: kPrimaryColor),
        // hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      onFieldSubmitted: (_) {},
    );
  }
}
