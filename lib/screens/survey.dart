import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../button.dart';
import '../constants.dart';
import '../models/questions.dart';
import '../screens/success.dart';
import '../size_config.dart';

class SurveyScreen extends StatefulWidget {
  static String routeName = "/survey";

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  var formValues = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
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

    _loading = false;
    print(context.read<QuestionnaireState>().survey);
    Navigator.of(context).popAndPushNamed(SuccessScreen.routeName);

    // Fluttertoast.showToast(
    //     msg: "No internet connection!",
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // print("Screen");
    // print(SizeConfig.screenWidth * 0.1556);
    List<Survey_questions> survey_questions =
        context.read<QuestionnaireState>().survey_questions;
    print(SizeConfig.imageSizeMultiplier * 50);
    print(Theme.of(context).textTheme.headline1.toString());

    // for (Survey_questions s in survey_questions) print(s.question);

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
                              for (Survey_questions s in survey_questions)
                                SurveyQuestionWidget(
                                    id: s.id, question: s.question),
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
                              ontap: () => _saveForm(),
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

class SurveyQuestionWidget extends StatelessWidget {
  const SurveyQuestionWidget({
    Key key,
    @required this.id,
    @required this.question,
  }) : super(key: key);

  final String question;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        TextFormField(
          minLines: 3,
          maxLines: 4,
          keyboardType: TextInputType.text,
          // validator: (value) => validateMobile(value),
          onSaved: (newValue) => newValue,
          onChanged: (value) {
            if (value.isNotEmpty) {
              // removeError(error: kEmailNullError);
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
          onFieldSubmitted: (newValue) {
            context.read<QuestionnaireState>().addSurveyAnswer(id, newValue);
          },
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
      ],
    );
  }
}
