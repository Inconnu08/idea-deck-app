import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea_deck/utils/notifications.dart';
import '../database/shared_perf.dart';
import '../models/questions.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/ads.dart';
import '../network/http.dart';
import '../screens/questions.dart';

class VideoDetailScreen extends StatefulWidget {
  static String routeName = "/details";
  final Advertisement a;

  VideoDetailScreen({this.a});

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
      '${getVideoUrl(widget.a.video)}',
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments ad = ModalRoute.of(context).settings.arguments;
    print('${getVideoUrl(widget.a.video)}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          widget.a.title,
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
                          label: Text(widget.a.brand,
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
                          (widget.a.participates != null)
                              ? widget.a.participates.toString()
                              : '0',
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
                  widget.a.description,
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
                if (widget.a.winner != null)
                  if (widget.a.winner == sharedPrefs.uid)
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: kPrimaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Text(
                                'You won!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 27),
                              ),
                              Text(
                                sharedPrefs.uid
                                    .substring(sharedPrefs.uid.length - 7),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                if (widget.a.winner == null)
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
                if (widget.a.winner == null)
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(40)),
                          color: (widget.a.status != 3)
                              ? kPrimaryColor
                              : Colors.grey),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: kAccent,
                          child: Container(
                            child: Text(
                              (widget.a.status != 3) ? 'Start' : 'Expired',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 27),
                            ),
                          ),
                          onTap: () => (widget.a.status != 3)
                              ? () {
                                  context
                                      .read<QuestionnaireState>()
                                      .offer_ends = widget.a.offer_ends;
                                  context
                                      .read<NotificationService>()
                                      .scheduledNotification(
                                          widget.a.offer_ends);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuestionsScreen(
                                              id: widget.a.id)));
                                }()
                              : null,
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
