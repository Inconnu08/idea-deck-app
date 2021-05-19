import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:idea_deck/utils/notifications.dart';
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
  double opacity = 0;
  Future<bool> postAnswersFuture;

  @override
  void initState() {
    super.initState();
    context.read<NotificationService>().scheduledNotification(
        time: context.read<QuestionnaireState>().offer_ends,
        brand: context.read<QuestionnaireState>().brand,
        qid: context.read<QuestionnaireState>().questionId);
    postAnswersFuture = postAnswers(
        context.read<QuestionnaireState>().questionId,
        context.read<QuestionnaireState>().jsonify());
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
                      var s =
                          context.read<QuestionnaireState>().suggestions;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 250,
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
                          SizedBox(height: 2),
                          Text(
                            "keep an eye out for the winner to be announced!",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: SizeConfig.screenHeight * 0.04),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Here are some suggested products and other offers you might be interested in.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                      height: getProportionateScreenHeight(20)),
                                  Container(
                                    height: getProportionateScreenHeight(250),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: q.suggestions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ProductCard(
                                            product: q.suggestions[index]);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(20)),
                                ],
                              ),
                            ),
                          ),
                          WidgetDialog(),
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
