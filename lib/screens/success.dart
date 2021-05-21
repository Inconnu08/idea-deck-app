import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/questions.dart';
import '../network/api.dart';
import '../screens/questions.dart';
import '../size_config.dart';
import '../utils/notifications.dart';
import '../widgets/product_card.dart';

class SuccessScreen extends StatefulWidget {
  static String routeName = "/success";

  @override
  _SuccessScreenState createState() => new _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  double opacity = 0;
  Future<bool> postAnswersFuture;
  Future<Questionnaire> fQuestionnaire;

  @override
  void initState() {
    super.initState();
    print(
        '================================================= ${context.read<QuestionnaireState>().offer_ends}');
    // schedule the notification
    context.read<NotificationService>().scheduledNotification(
        time: context.read<QuestionnaireState>().offer_ends,
        brand: context.read<QuestionnaireState>().brand,
        qid: context.read<QuestionnaireState>().questionId);

    // post the answers for questionanire and survey
    postAnswersFuture = postAnswers(
        context.read<QuestionnaireState>().questionId,
        context.read<QuestionnaireState>().jsonify());

    // fetch suggested products
    fQuestionnaire =
        fetchQuestionnaire(context.read<QuestionnaireState>().questionId);
  }

  changeOpacity() {
    if (opacity == 1.0) return;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = 1.0;
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
            print('postAnswersFuture snapshot: ${snapshot.hasData}');
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
                      var s = context.read<QuestionnaireState>().suggestions;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 250,
                            child: Center(
                                child: const FlareActor("assets/check.flr",
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    animation: 'play')),
                          ),
                          Text(
                            "You have successfully entered the draw!",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
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
                                  SizedBox(
                                      height: getProportionateScreenHeight(20)),
                                  if (s != null)
                                    if (s.isNotEmpty)
                                      Container(
                                        height:
                                            getProportionateScreenHeight(250),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: s.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ProductCard(
                                                product: s[index]);
                                          },
                                        ),
                                      ),
                                  if (s?.isNotEmpty)
                                    Container(
                                      height: getProportionateScreenHeight(250),
                                      child: FutureBuilder<Questionnaire>(
                                          future: fQuestionnaire,
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                              case ConnectionState.waiting:
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              default:
                                                if (snapshot.hasData) {
                                                  var s =
                                                      snapshot.data.suggestions;
                                                  return Container(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            250),
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: s.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ProductCard(
                                                            product: s[index]);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                            }
                                          }),
                                    ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(20)),
                                ],
                              ),
                            ),
                          ),
                          const WidgetDialog(),
                          SizedBox(height: getProportionateScreenHeight(20)),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            }
          }),
    ));
  }
}
