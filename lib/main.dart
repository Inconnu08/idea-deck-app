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
  // ignore: use_key_in_widget_constructors
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
      controlBarColor: Colors.white,
      iconsColor: kPrimaryColor,
      progressBarPlayedColor: buttonColor,
      progressBarHandleColor: buttonColor,
      enableSkips: false,
      enableFullscreen: true,
      enableProgressBarDrag: false,
      loadingColor: kAccent,
      overflowModalTextColor: Colors.white,
      overflowMenuIconsColor: Colors.white,
    );

    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoDetectFullscreenDeviceOrientation: true,
            controlsConfiguration: controlsConfiguration
            );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://res.cloudinary.com/dxisrwiao/video/upload/v1613809156/e0ulp3n1glxioxho7ubt.m3u8",
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }
  // VideoPlayerController _videoPlayerController1;
  // ChewieController _chewieController;

  // @override
  // void initState() {
  //   super.initState();
  //   initializePlayer();
  // }

  // @override
  // void dispose() {
  //   _videoPlayerController1.dispose();
  //   _chewieController?.dispose();
  //   super.dispose();
  // }

  // Future<void> initializePlayer() async {
  //   _videoPlayerController1 = VideoPlayerController.network(
  //       'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');

  //   await _videoPlayerController1.initialize();

  //   _chewieController = ChewieController(
  //     videoPlayerController: _videoPlayerController1,
  //     aspectRatio: 16 / 9,
  //     autoPlay: false,
  //     looping: false,
  //     allowedScreenSleep: false,
  //     allowPlaybackSpeedChanging: false,
  //     errorBuilder: (context, errorMessage) {
  //       return Center(
  //         child: Text(
  //           "Something went wrong! Please try later.",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       );
  //     },
  //     // Try playing around with some of these other options:

  //     // showControls: false,
  //     materialProgressColors: ChewieProgressColors(
  //       playedColor: kPrimaryColor,
  //       handleColor: kPrimaryColor,
  //       backgroundColor: lightText,
  //       bufferedColor: Colors.grey,
  //     ),
  //     // autoInitialize: true,
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // _chewieController != null
              //     ?
              // ? Container(
              //   height: 300,
              //   child: Chewie(
              //       controller: _chewieController,
              //     ),
              // )
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(controller: _betterPlayerController),
              ),
              // : Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       CircularProgressIndicator(),
              //       SizedBox(height: 20),
              //       Text('Loading'),
              //     ],
              //   ),

              Row(
                children: <Widget>[
                  // TextButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _chewieController.dispose();
                  //       _videoPlayerController1.pause();
                  //       _videoPlayerController1.seekTo(const Duration());
                  //       _chewieController = ChewieController(
                  //         videoPlayerController: _videoPlayerController1,
                  //         autoPlay: true,
                  //         looping: true,
                  //       );
                  //     });
                  // },
                  //   child: const Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 16.0),
                  //     child: Text("Landscape Video"),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
