import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../button.dart';
import '../constants.dart';
import '../models/questions.dart';
import '../network/api.dart';
import '../size_config.dart';
import 'home.dart';

class SuccessScreen extends StatefulWidget {
  static String routeName = "/success";

  @override
  _SuccessScreenState createState() => new _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  // final FlareControls controls = FlareControls();
  double opacity = 0;
  Future<bool> postAnswersFuture;

  @override
  void initState() {
    super.initState();
    postAnswersFuture = postAnswers(
        context.read<QuestionnaireState>().questionId,
        context.read<QuestionnaireState>().jsonify());
    //changeOpacity();
  }

  changeOpacity() {
    if (opacity == 1.0) return;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = 1.0;
        print("object");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(16),
      child: FutureBuilder<bool>(
          future: postAnswersFuture,
          builder: (BuildContext context, snapshot) {
            print("snapshot.hasData");
            print(snapshot.hasData);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Opps! Something went wrong!'));
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      changeOpacity();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 350,
                            child: Center(
                                child: FlareActor("assets/check.flr",
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    animation: 'play')),
                          ),
                          Text(
                            "You have successfully entered the draw!",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "keep an eye out for the winner to be announced!",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(height: 50),
                          AnimatedOpacity(
                            opacity: opacity,
                            duration: Duration(seconds: 1),
                            child: Center(
                              child: Container(
                                width: 200,
                                child: ThemeButton(
                                    color: buttonColor,
                                    text: "Go back",
                                    ontap: () =>
                                        Navigator.pushAndRemoveUntil<dynamic>(
                                          context,
                                          MaterialPageRoute<dynamic>(
                                            builder: (BuildContext context) =>
                                                HomeScreen(),
                                          ),
                                          (route) =>
                                              false, //if you want to disable back feature set to false
                                        )),
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                        ],
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
            }
          }),
    ));
  }
}
