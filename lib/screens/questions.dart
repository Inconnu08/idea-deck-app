import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../models/ads.dart';

class QuestionsScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "How many monkeys were dancing on the largest tree that has a refractive index of 35 degress perpendicular to your eyes followed by a shadow depth equaling to the light shone on the white monkey?",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                          child: Divider(thickness: 0.5, color: kPrimaryColor),
                        ),

                        AnswerOption(answer: 'There were 430 monkeys dancing.'),
                        AnswerOption(
                            answer:
                                'There were no monkeys dancing that\'s for sure.'),
                        AnswerOption(answer: "There were 2 monkeys dancing."),
                        AnswerOption(
                            answer: 'There were 4340 monkeys dancing.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Expanded(
                  child: DragTarget<String>(onAccept: (value) {
                    setState(() {
                      // _targetImageUrl = value;
                      print("complete $value");
                    });
                  }, builder: (_, candidateData, rejectedData) {
                    return Container(
                      alignment: Alignment.center,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: kPrimaryColor),
                      child: Container(
                        child: Text(
                          'Drag your answer here',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
            style: TextStyle(fontSize: 12.0, color: kPrimaryColor)),
      ),
      // The widget to show under the pointer when a drag is under way
      feedback: Opacity(
        opacity: 0.4,
        child: Material(
          child: Container(
            child: Chip(
              backgroundColor: kAccent,
              label: Text(answer,
                  style: TextStyle(fontSize: 12.0, color: kPrimaryColor)),
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
