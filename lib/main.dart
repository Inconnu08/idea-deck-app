import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:idea_deck/screens/video_details.dart';

import './routes.dart';
import './size_config.dart';
import './theme.dart';

main() {
  // debugPaintSizeEnabled=true;
  runApp(DevicePreview(
    // enabled: !kReleaseMode,
    enabled: false,
    builder: (context) => LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MyApp();
      });
    }),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idea Deck',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: VideoDetailScreen(),
      routes: routes,
    );
  }
}
