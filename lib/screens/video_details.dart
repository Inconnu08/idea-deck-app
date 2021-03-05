import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../models/ads.dart';

class VideoDetailScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  _VideoDetailScreenState createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: kPrimaryColor));

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
            const Padding(
              padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
              child: Divider(thickness: 0.5, color: kPrimaryColor),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  'D/SurfaceUtils(14820): disconnecting from surface 0x779a59c010, reason disconnectFromSurfaceD/CCodecBufferChannel(14820): [c2.qti.avc.decoder#142] MediaCodec discarded an unknown bufferI/chatty  (14820): uid=10297(com.ideadeck.idea_deck) MediaCodec_loop identical 6 linesD/CCodecBufferChannel(14820): [c2.qti.avc.decoder#142] MediaCodec discarded an unknown bufferD/SurfaceUtils(14820): disconnecting from surface 0x779a6199c0, reason disconnectFromSurfaceI/hw-BpHwBinder(14820): onLastStrongRef automatically unlinking death recipients D/SurfaceUtils(14820): disconnecting from surface 0x779a59c010, reason disconnectFromSurfaceD/CCodecBufferChannel(14820): [c2.qti.avc.decoder#142] MediaCodec discarded an unknown bufferI/chatty  (14820): uid=10297(com.ideadeck.idea_deck) MediaCodec_loop identical 6 linesD/CCodecBufferChannel(14820): [c2.qti.avc.decoder#142] MediaCodec discarded an unknown bufferD/SurfaceUtils(14820): disconnecting from surface 0x779a6199c0, reason disconnectFromSurfaceI/hw-BpHwBinder(14820): onLastStrongRef automatically unlinking death recipients',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.grey),
                ),
              ),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Answer questions',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(40)),
                        color: kPrimaryColor),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: kAccent,
                        child: Container(
                          child: Text(
                            'Start',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 27),
                          ),
                        ),
                        onTap: () => 1 - 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final Advertisement ad;

  ScreenArguments(this.ad);
}
