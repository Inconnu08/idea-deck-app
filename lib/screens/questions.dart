import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idea_deck/utils/notifications.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/ads.dart';
import '../models/questions.dart';
import '../network/api.dart';
import '../screens/success.dart';
import '../screens/survey.dart';
import '../size_config.dart';
import '../widgets/product_card.dart';

class QuestionsScreen extends StatefulWidget {
  static String routeName = "/questions";
  final int id;

  const QuestionsScreen({Key key, @required this.id}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Future<Questionnaire> fQuestionnaire;
  int totalQuestions;
  PageController _pageController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
    context.read<QuestionnaireState>().initState();
    fQuestionnaire = fetchQuestionnaire(widget.id);
    _pageController = PageController();
    context.read<QuestionnaireState>().questionId = widget.id;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: FutureBuilder<Questionnaire>(
                future: fQuestionnaire,
                builder: (BuildContext context, snapshot) {
                  print(snapshot.hasData);
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                            child: Text(
                                'Opps! Something went wrong! ${snapshot.error}'));
                      } else {
                        if (snapshot.hasData) {
                          Questionnaire q = snapshot.data;
                          print(q);
                          if (q.questions == null ||
                              q.survey_questions == null) {
                            if (q.survey_questions != null)
                              context
                                  .read<QuestionnaireState>()
                                  .survey_questions = q.survey_questions;

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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.04),
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
                                            height:
                                                getProportionateScreenHeight(
                                                    20)),
                                        Container(
                                          height:
                                              getProportionateScreenHeight(250),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: q.suggestions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ProductCard(
                                                  product:
                                                      q.suggestions[index]);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    20)),
                                      ],
                                    ),
                                  ),
                                ),
                                WidgetDialog(),
                                SizedBox(
                                    height: getProportionateScreenHeight(20)),
                              ],
                            );
                          }

                          totalQuestions = q.questions.length;
                          context
                              .read<QuestionnaireState>()
                              .setTotalQuestions(widget.id, q.questions.length);

                          context.read<QuestionnaireState>().survey_questions =
                              q.survey_questions;

                          print(q.questions);

                          return SafeArea(
                            child: SizedBox.expand(
                              child: PageView(
                                controller: _pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                onPageChanged: (index) {
                                  setState(() => index);
                                },
                                children: <Widget>[
                                  // ADD QUESTIONS PAGE SLIDER
                                  for (Question q in q.questions)
                                    QuestionCard(
                                        pageController: _pageController,
                                        question: q),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }
                  }
                }),
          )),
    );
  }
}

class WidgetDialog extends StatefulWidget {
  const WidgetDialog({
    Key key,
  }) : super(key: key);

  @override
  _WidgetDialogState createState() => _WidgetDialogState();
}

class _WidgetDialogState extends State<WidgetDialog> {
  void initState() {
    super.initState();
    if (context.read<QuestionnaireState>().survey_questions != null) if (context
        .read<QuestionnaireState>()
        .survey_questions
        .isNotEmpty)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(seconds: 2)).then((_) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                    title: Text("Survey",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    content: Text(
                        "Would you like to complete a survey for an additional entry to the draw?"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Yes"),
                        textColor: Colors.green,
                        onPressed: () {
                          Navigator.of(context)
                              .popAndPushNamed(SurveyScreen.routeName);
                        },
                      ),
                      FlatButton(
                        child: Text("No"),
                        textColor: Colors.redAccent,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 1);
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key key,
    @required PageController pageController,
    @required this.question,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final Question question;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          height: 50,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
              color: kPrimaryColor),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${context.watch<QuestionnaireState>().currentQuestionNo + 1} of ${context.watch<QuestionnaireState>().totalQuestions}",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .8914,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width * 0.80,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SurveyScreen.routeName),
                      child: Text(
                        widget.question.question,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                      child: Divider(thickness: 0.5, color: kPrimaryColor),
                    ),
                    AnswerOption(answer: widget.question.option_1),
                    AnswerOption(answer: widget.question.option_2),
                    AnswerOption(answer: widget.question.option_3),
                    AnswerOption(answer: widget.question.option_4),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: DragTarget<String>(onAccept: (answer) {
                      setState(() {
                        print("complete-> $answer");
                        if (context.read<QuestionnaireState>().isEnd()) {
                          // save answer
                          context
                              .read<QuestionnaireState>()
                              .addQuestionAnswer(widget.question.id, answer);
                          // increment to next question
                          context.read<QuestionnaireState>().nextQuestion();
                          // next index
                          var index = context
                              .read<QuestionnaireState>()
                              .currentQuestionNo;
                          // go to next page
                          widget._pageController.animateToPage(index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInExpo);
                        } else {
                          print("END REACHED!");
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("Survey",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    content: Text(
                                        "Would you like to complete a survey for an additional entry to the draw?"),
                                    // backgroundColor: this._color,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text("Yes"),
                                        textColor: Colors.green,
                                        onPressed: () {
                                          Navigator.of(context).popAndPushNamed(
                                              SuccessScreen.routeName);
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text("No"),
                                        textColor: Colors.redAccent,
                                        onPressed: () {
                                          Navigator.of(context).popAndPushNamed(
                                              SuccessScreen.routeName);
                                        },
                                      ),
                                    ],
                                  ));
                        }
                      });
                    }, builder: (_, candidateData, rejectedData) {
                      return Container(
                        alignment: Alignment.center,
                        height: 80,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: kPrimaryColor),
                        child: Text(
                          'Drag your answer here',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class QuestionPostStatus extends StatelessWidget {
//   final int id;
//   QuestionPostStatus({
//     Key key,
//     @required this.id,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var data = context.read<QuestionnaireState>().jsonify();
//     return AlertDialog(
//       content: Container(
//         height: 200,
//         child: FutureBuilder<bool>(
//             future: postAnswers(id, data),
//             builder: (BuildContext context, snapshot) {
//               print(snapshot.hasData);
//               switch (snapshot.connectionState) {
//                 case ConnectionState.none:
//                 case ConnectionState.waiting:
//                   return Center(child: CircularProgressIndicator());
//                 default:
//                   if (snapshot.hasError) {
//                     print(snapshot.error);
//                     return Center(child: Text('Opps! Something went wrong!'));
//                   } else {
//                     if (snapshot.hasData) {
//                       context
//                           .read<NotificationService>()
//                           .scheduledNotification(a.offer_end);
//                       Fluttertoast.showToast(
//                           msg: 'Successfully submitted!',
//                           toastLength: Toast.LENGTH_LONG,
//                           gravity: ToastGravity.BOTTOM,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.green,
//                           textColor: Colors.white,
//                           fontSize: 16.0);
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pop();
//                       return Center(child: CircularProgressIndicator());
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   }
//               }
//             }),
//       ),
//       // backgroundColor: this._color,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       // actions: <Widget>[
//       //   FlatButton(
//       //     child: Text("Yes"),
//       //     textColor: Colors.green,
//       //     onPressed: () {
//       //       Navigator.of(context).pop();
//       //     },
//       //   ),
//       //   FlatButton(
//       //     child: Text("No"),
//       //     textColor: Colors.redAccent,
//       //     onPressed: () {
//       //       Navigator.of(context).pop();
//       //     },
//       //   ),
//       // ],
//     );
//   }
// }

class AnswerOption extends StatelessWidget {
  final String answer;
  const AnswerOption({Key key, this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: answer,
      child: Chip(
        backgroundColor: kAccent,
        label: Text(answer,
            style: const TextStyle(fontSize: 12.0, color: kPrimaryColor)),
      ),
      // The widget to show under the pointer when a drag is under way
      feedback: Opacity(
        opacity: 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            child: Chip(
              backgroundColor: kAccent,
              label: Text(answer,
                  style: const TextStyle(fontSize: 12.0, color: kPrimaryColor)),
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
