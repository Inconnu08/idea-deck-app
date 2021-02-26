import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import './size_config.dart';
import './splash.dart';

main() {
  runApp(DevicePreview(
    // enabled: !kReleaseMode,
    enabled: true,
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
      title: 'Drawing Paths',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
