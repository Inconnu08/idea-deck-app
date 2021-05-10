import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:idea_deck/constants.dart';
import 'package:idea_deck/models/questions.dart';
import 'package:idea_deck/screens/suggest.dart';
import 'package:idea_deck/screens/survey.dart';
import 'package:idea_deck/screens/video_details.dart';
import 'package:provider/provider.dart';

import './routes.dart';
import './size_config.dart';
import './theme.dart';
import 'button.dart';
import 'database/shared_perf.dart';
import 'network/connectivity.dart';
import 'screens/home.dart';
import 'screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:flare_flutter/flare_actor.dart';

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
      home: MyHomePage(),
      routes: routes,
    );
  }
}

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   void _togglePlay() {
//     setState(() => _controller.isActive = !_controller.isActive);
//   }

//   /// Tracks if the animation is playing by whether controller is running.
//   bool get isPlaying => _controller?.isActive ?? false;

//   Artboard _riveArtboard;
//   RiveAnimationController _controller;
//   @override
//   void initState() {
//     super.initState();

//     // Load the animation file from the bundle, note that you could also
//     // download this. The RiveFile just expects a list of bytes.
//     rootBundle.load('assets/check.flr2d').then(
//       (data) async {
//         // Load the RiveFile from the binary data.
//         final file = RiveFile.import(data);
//         // The artboard is the root of the animation and gets drawn in the
//         // Rive widget.
//         final artboard = file.mainArtboard;
//         // Add a controller to play back a known animation on the main/default
//         // artboard.We store a reference to it so we can toggle playback.
//         artboard.addController(_controller = SimpleAnimation('idle'));
//         setState(() => _riveArtboard = artboard);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _riveArtboard == null
//             ? const SizedBox()
//             : Rive(artboard: _riveArtboard),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _togglePlay,
//         tooltip: isPlaying ? 'Pause' : 'Play',
//         child: Icon(
//           isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final FlareControls controls = FlareControls();
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = 1.0;
        // changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(16),
      child: Column(
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
            "Best of luck!",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 15),
          Text(
            "You have successfully entered the draw!",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold, color: kPrimaryColor),
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
                    ontap: () => Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => HomeScreen(),
                          ),
                          (route) =>
                              false, //if you want to disable back feature set to false
                        )),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    ));
  }
}
