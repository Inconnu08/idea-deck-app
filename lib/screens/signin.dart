import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idea_deck/database/shared_perf.dart';
import 'package:idea_deck/network/api.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../button.dart';
import '../constants.dart';
import '../screens/reset_password.dart';
import '../screens/signup.dart';
import '../screens/home.dart';
import '../size_config.dart';
import '../utils/validators.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign-in";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  var formValues = {};
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

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

    _formKey.currentState.save();

    try {
      var r = await login(formValues['phone'], formValues['password']);

      print('body: ${r.body}');
      var b = json.decode(r.body);
      var s = r.statusCode;
      print('status code s: $s');
      print('status code direct: ${r.statusCode}');

      if (s != 200) {
        if (s == 402) {
          sharedPrefs.token = b['token'];
          print(b['email']);
          print(b['id']);
          sharedPrefs.uid = b['id'];
          sharedPrefs.name = b['name'];
          sharedPrefs.phone = b['phone'];
          sharedPrefs.email = b['email'];
          sharedPrefs.firstLaunch = false;
          Fluttertoast.showToast(
              msg: b['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          // Navigator.of(context).pop();
          // if (p['referral'] != null) {
          //   print("===============================>${p['referral']})");
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => PaymentOptionsScreen(true)),
          //   );
          //   return;
          // }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => PaymentOptionsScreen(false)),
          // );
        }
        if (s == 400) {
          Fluttertoast.showToast(
              msg: "Incorrect email or password!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            _loading = false;
          });
          return;
        }
      }

      print(b);
      print(b['name']);
      print(b['email']);
      print(b['id']);
      sharedPrefs.uid = b['id'];
      sharedPrefs.name = b['name'];
      sharedPrefs.phone = b['phone'];
      sharedPrefs.email = b['email'];
      sharedPrefs.token = b['token'];
      sharedPrefs.firstLaunch = false;
      // storeAuth(context, r.body);

      Navigator.popAndPushNamed(context, HomeScreen.routeName);
    } on SocketException catch (e) {
      print("Socket Exception: $e");
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: "No internet connection!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // _loading = false;
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
                    "Welcome to",
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildPhoneFormField(),
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                              buildPasswordFormField(),
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
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
                              text: "Connect",
                              ontap: () => _saveForm()
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      focusNode: _passwordFocusNode,
      onSaved: (newValue) => formValues['password'] = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          // removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) => validateEmpty(value),
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(color: kPrimaryColor),
        // hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      validator: (value) => validateMobile(value),
      onSaved: (newValue) => formValues['phone'] = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          // removeError(error: kInvalidEmailError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        labelStyle: const TextStyle(color: kPrimaryColor),
        // hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }
}
