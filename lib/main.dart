import 'package:better_player/better_player.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './routes.dart';
import './screens/splash.dart';
import './size_config.dart';
import './theme.dart';
import 'constants.dart';

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
      home: ChewieDemo(),
      routes: routes,
    );
  }
}

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({this.title = 'Chewie Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerControlsConfiguration controlsConfiguration =
        BetterPlayerControlsConfiguration(
            controlBarColor: Colors.white.withOpacity(0.1),
            iconsColor: buttonColor,
            progressBarPlayedColor: buttonColor,
            progressBarHandleColor: buttonColor,
            enableSkips: false,
            enableFullscreen: true,
            enableProgressBarDrag: false,
            loadingColor: kAccent,
            overflowModalTextColor: Colors.white,
            overflowMenuIconsColor: Colors.white,
            enableOverflowMenu: false);

    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoDetectFullscreenDeviceOrientation: true,
            controlsConfiguration: controlsConfiguration);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
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
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _betterPlayerController),
            ),
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
                          "All in or nothing, win a pair of boots!",
                          maxLines: 4,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Chip(
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(15.0),
                          // ),
                          backgroundColor: kAccent,
                          // avatar: CircleAvatar(
                          //   backgroundColor: kPrimaryColor,
                          // ),
                          label: Text('Cheez',
                              style: TextStyle(
                                  fontSize: 12.0, color: kPrimaryColor)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "4520",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Entries",
                          style: Theme.of(context).textTheme.caption.copyWith(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(thickness: 1),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'D/SurfaceUtils(14820): disconnecting from surface 0x779a59c010, reason disconnectFromSurfaceD/CCodecBufferChannel(14820): [c2.qti.avc.decoder#142] MediaCodec discarded an unknown bufferI/chatty  (14820): uid=10297(com.ideadeck.idea_deck) MediaCodec_loop identical 6 linesD/CCodecBufferChannel(14820): [c2.qti.avc.decoder#142] MediaCodec discarded an unknown bufferD/SurfaceUtils(14820): disconnecting from surface 0x779a6199c0, reason disconnectFromSurfaceI/hw-BpHwBinder(14820): onLastStrongRef automatically unlinking death recipients',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
