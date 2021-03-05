import 'package:flutter/widgets.dart';

import './screens/home.dart';
import './screens/profile.dart';
import './screens/questions.dart';
import './screens/reset_password.dart';
import './screens/signin.dart';
import './screens/signup.dart';
import './screens/splash.dart';
import './screens/video_details.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  VideoDetailScreen.routeName: (context) => VideoDetailScreen(),
  QuestionsScreen.routeName: (context) => QuestionsScreen(),
};
