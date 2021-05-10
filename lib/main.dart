import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/questions.dart';
import './routes.dart';
import './size_config.dart';
import './theme.dart';
import 'database/shared_perf.dart';
import 'network/connectivity.dart';
import 'screens/splash.dart';

main() async {
  // debugPaintSizeEnabled=true;
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  await sharedPrefs.init();
  runApp(
    // DevicePreview(
    // enabled: !kReleaseMode,
    // enabled: false,
    // builder: (context) =>
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionnaireState()),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MyApp();
        });
      }),
    ),
  );
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idea Deck',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
