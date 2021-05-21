import 'package:flutter/material.dart';

import '../screens/home.dart';

class VideoDetailByIDScreen extends StatelessWidget {
  static String routeName = "/details_by_id";
  final String vid;

  VideoDetailByIDScreen({this.vid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: AdvertisementFeed(vid: this.vid)),
    );
  }
}
