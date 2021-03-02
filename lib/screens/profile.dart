import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../models/ads.dart';
import '../size_config.dart';
import '../widgets/search_field.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);

    print(SizeConfig.imageSizeMultiplier * 50);
    print(Theme.of(context).textTheme.headline1.toString());

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.40
                : MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: const Radius.circular(50.0),
                bottomRight: const Radius.circular(50.0),
              ),
              color: kPrimaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "\n Profile",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "  John Doe",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.white),
                        ),
                        Center(child: CircleAvatar(radius: 36)),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.phone, color: Colors.white),
                                    Text("01716857684",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                            color: Colors.white)),
                                  ]),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.email, color: Colors.white),
                                  Text("bryan@gmail.com",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white)),
                                ],
                              )
                            ]),
                      ]),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          top: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * 0.401
              : MediaQuery.of(context).size.height / 3.8,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 32, left: 32),
                      child: Card(
                        elevation: 8,
                        shape: StadiumBorder(),
                        color: kAccent,
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            "1. Raihan Ahmed Kobra Kai",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          trailing: Text("3645 entries"),
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32, left: 32),
                      child: Card(
                        elevation: 8,
                        shape: StadiumBorder(),
                        color: kAccent,
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            "2. Saimon",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          trailing: Text("2398 entries"),
                          shape: StadiumBorder(),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ],
    ));
  }
}

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.30
                : MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: const Radius.circular(50.0),
                bottomRight: const Radius.circular(50.0),
              ),
              color: kPrimaryColor,
              image: DecorationImage(
                alignment: Alignment.center,
                matchTextDirection: true,
                repeat: ImageRepeat.noRepeat,
                image: AssetImage(
                  'assets/lb.png',
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Leaderboard",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: CircleAvatar()),
                            Center(child: CircleAvatar(radius: 42)),
                            Center(child: CircleAvatar()),
                          ],
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          top: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * 0.301
              : MediaQuery.of(context).size.height / 3.8,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 32, left: 32),
                      child: Card(
                        elevation: 8,
                        shape: StadiumBorder(),
                        color: kAccent,
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            "1. Raihan Ahmed Kobra Kai",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          trailing: Text("3645 entries"),
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32, left: 32),
                      child: Card(
                        elevation: 8,
                        shape: StadiumBorder(),
                        color: kAccent,
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            "2. Saimon",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          trailing: Text("2398 entries"),
                          shape: StadiumBorder(),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

class AdvertisementFeed extends StatelessWidget {
  AdvertisementFeed({
    Key key,
  }) : super(key: key);

  final ads = getAds();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Offers",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 16.0, left: 16.0),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: SearchField()),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(
                          icon: Icon(Icons.filter_list,
                              size: 36, color: kPrimaryColor),
                          onPressed: null),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
