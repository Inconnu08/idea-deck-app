import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea_deck/models/entries.dart';
import 'package:idea_deck/models/profile.dart';
import 'package:idea_deck/network/api.dart';
import 'package:idea_deck/screens/video_details.dart';

import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<Profile> fprofile;

  @override
  void initState() {
    fprofile = fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);

    // print(SizeConfig.imageSizeMultiplier * 50);
    // print(Theme.of(context).textTheme.headline1.toString());

    return Scaffold(
      body: Container(
        child: FutureBuilder<Profile>(
            future: fprofile,
            builder: (BuildContext context, snapshot) {
              print(snapshot.hasData);
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return new Text('Opps! Something went wrong!');
                  } else {
                    if (snapshot.hasData) {
                      print('===========================');
                      print(snapshot.data);
                      Profile p = snapshot.data;
                      return Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0.0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "\n Profile",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                .copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            "  ${p.full_name}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(color: Colors.white),
                                          ),
                                          Center(
                                              child: CircleAvatar(radius: 36)),
                                          SizedBox(height: 20),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(Icons.phone,
                                                          color: Colors.white),
                                                      Text(p.phone,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                              color: Colors
                                                                  .white)),
                                                    ]),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.email,
                                                        color: Colors.white),
                                                    Text(p.email,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            color:
                                                                Colors.white)),
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
                            top: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.401
                                : MediaQuery.of(context).size.height / 3.8,
                            child: SingleChildScrollView(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            32.0, 32.0, 32.0, 0),
                                        child: Text(
                                          "Draws entered",
                                          maxLines: 4,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.8,
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: ListView.builder(
                                          itemCount: p.entries.length,
                                          itemBuilder: (context, index) {
                                            var a = p.entries[index];

                                            return EntryCard(a: a);
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
              }
            }),
      ),
    );
  }
}

class EntryCard extends StatelessWidget {
  const EntryCard({
    Key key,
    @required this.a,
  }) : super(key: key);

  final Entries a;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 0,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, VideoDetailScreen.routeName);
                  print("beep");
                },
                child: null,
                highlightColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                splashColor: kAccent,
              ),
              // decoration: BoxDecoration(
              //   color: kAccent,
              //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
              //   image: DecorationImage(
              //     image: NetworkImage(imageBaseUrl + a.video_thumbnail),
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Text(a.video_title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w100)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Text('',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: buttonColor)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 16.0, left: 16.0, right: 16.0),
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Text(a.video_type(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w100, color: Colors.grey)),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom:16, left: 16.0, right:16.0),
                //   child: Text('${a.offerEnds}',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold)),
                // ),
              ],
            ),
            // ExpandIcon(
            //   onPressed: (bool value) {},
            // )
          ],
        ));
  }
}
