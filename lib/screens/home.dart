import 'dart:convert';
import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:http/http.dart';
import 'package:idea_deck/database/shared_perf.dart';
import 'package:idea_deck/models/leaderboard.dart';
import 'package:idea_deck/network/api.dart';
import 'package:idea_deck/network/connectivity.dart';
import 'package:idea_deck/network/http.dart';
import 'package:idea_deck/screens/profile.dart';
import 'package:idea_deck/screens/survey.dart';
import 'package:idea_deck/screens/video_details.dart';
import 'package:idea_deck/utils/notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/ads.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
        
    context.read<NotificationService>().context = context;

    print(SizeConfig.imageSizeMultiplier * 50);
    print(Theme.of(context).textTheme.headline1.toString());

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
              "Offers",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            actions: <Widget>[
              InkWell(
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://www.pngfind.com/pngs/m/488-4887957_facebook-teerasej-profile-ball-circle-circular-profile-picture.png'),
                  backgroundColor: Colors.transparent,
                ),
                onTap: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
              SizedBox(width: 16)
            ]),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              AdvertisementFeed(),
              const LeaderBoard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Notifications",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            elevation: 8,
                            color: kAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading:
                                    Icon(Icons.explicit, color: kPrimaryColor),
                                title: Text(
                                  "Congratulations! You won the draw for something!",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 8,
                            color: kAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Icon(
                                    Icons.swap_horizontal_circle_rounded,
                                    color: kPrimaryColor),
                                title: Text(
                                  "You have been entered to the draw!",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.apps),
                title: Text('Home',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: kPrimaryColor, fontWeight: FontWeight.bold)),
                activeColor: kPrimaryColor),
            BottomNavyBarItem(
              icon: Icon(Icons.leaderboard),
              title: Text('Leaderboard',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: kPrimaryColor, fontWeight: FontWeight.bold)),
              activeColor: kPrimaryColor,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.notifications),
              title: Text('Notifications',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: kPrimaryColor, fontWeight: FontWeight.bold)),
              activeColor: kPrimaryColor,
            )
          ],
        ));
  }
}

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({
    Key key,
  }) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Future<dynamic> leaderboardFuture;

  @override
  void initState() {
    leaderboardFuture = fetchLeaderBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Leaderboard>(
          future: leaderboardFuture,
          builder: (BuildContext context, snapshot) {
            print(snapshot.hasData);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Opps! Something went wrong!'));
                } else {
                  if (snapshot.hasData) {
                    Leaderboard l = snapshot.data;

                    return Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0.0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Leaderboard",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(color: Colors.white),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage((l
                                                              .leaderboard
                                                              .length <
                                                          2)
                                                      ? "$mediaBaseUrl${l.leaderboard[2].picture}"
                                                      : ""),
                                                  backgroundColor:
                                                      Colors.white),
                                            ),
                                            Center(
                                              child: CircleAvatar(
                                                  radius: 42,
                                                  backgroundImage: NetworkImage(
                                                      "$mediaBaseUrl${l.leaderboard[0].picture}"),
                                                  backgroundColor:
                                                      Colors.white),
                                            ),
                                            Center(
                                              child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      "$mediaBaseUrl${l.leaderboard[1].picture}"),
                                                  backgroundColor:
                                                      Colors.white),
                                            ),
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
                          top: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.301
                              : MediaQuery.of(context).size.height / 3.8,
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount: l.leaderboard.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 32, left: 32),
                                    child: Card(
                                      elevation: 8,
                                      shape: StadiumBorder(),
                                      color: kAccent,
                                      child: ListTile(
                                        leading: CircleAvatar(),
                                        title: Text(
                                          "${index + 1}. ${l.leaderboard[index].full_name}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                        trailing: Text(
                                            "${l.leaderboard[index].entries} entries"),
                                        shape: StadiumBorder(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: <Widget>[
                              //       Padding(
                              //         padding: const EdgeInsets.only(
                              //             right: 32, left: 32),
                              //         child: Card(
                              //           elevation: 8,
                              //           shape: StadiumBorder(),
                              //           color: kAccent,
                              //           child: ListTile(
                              //             leading: CircleAvatar(),
                              //             title: Text(
                              //               "1. Raihan Ahmed Kobra Kai",
                              //               overflow: TextOverflow.ellipsis,
                              //               maxLines: 1,
                              //               style:
                              //                   TextStyle(color: kPrimaryColor),
                              //             ),
                              //             trailing: Text("3645 entries"),
                              //             shape: StadiumBorder(),
                              //           ),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(
                              //             right: 32, left: 32),
                              //         child: Card(
                              //           elevation: 8,
                              //           shape: StadiumBorder(),
                              //           color: kAccent,
                              //           child: ListTile(
                              //             leading: CircleAvatar(),
                              //             title: Text(
                              //               "2. Saimon",
                              //               style:
                              //                   TextStyle(color: kPrimaryColor),
                              //             ),
                              //             trailing: Text("2398 entries"),
                              //             shape: StadiumBorder(),
                              //           ),
                              //         ),
                              //       )
                              //     ]),
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
    );
  }
}

class AdvertisementFeed extends StatefulWidget {
  AdvertisementFeed({
    Key key,
  }) : super(key: key);

  @override
  _AdvertisementFeedState createState() => _AdvertisementFeedState();
}

class _AdvertisementFeedState extends State<AdvertisementFeed> {
  // final ads = getAds();
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  String searchCategory = 'All';

  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).initialize();
    super.initState();
  }

  Widget listItemBuilder(value, int index) {
    // print(value.offer_ends);
    // var dmyString = value.offer_ends;
    // var dateTime1 = DateFormat('d/M/yyyy h:m a').parse(dmyString);
    // print(dateTime1);
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: AdvertisementCard(a: value),
    );
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget errorWidgetMaker(PaginatedProducts pp, retryListener) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(pp.errorMessage ?? "error"),
          ),
          OutlinedButton(
            style: outlineButtonStyle,
            onPressed: retryListener,
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }

  Widget emptyListWidgetMaker(PaginatedProducts pp) {
    return const Center(
      child: Text('No advertiment found.\nSearch something else.'),
    );
  }

  int totalPagesGetter(PaginatedProducts p) {
    return p.count;
  }

  bool pageErrorChecker(PaginatedProducts p) {
    return p.statusCode != 200;
  }

  List<Advertisement> listItemsGetter(PaginatedProducts p) {
    List<Advertisement> list = [];
    p.results.forEach((value) {
      list.add(value);
    });
    return list;
  }

  Future<PaginatedProducts> fetchAdvertisements(int page) async {
    //   '${baseURL}videos?cat=${widget.category.slug}&page=$page',
    int cat;
    if (cat == 'All') cat = null;
    switch (searchCategory) {
      case 'All':
        cat = null;
        break;
      case 'Currently open':
        cat = 0;
        break;
      case 'Upcoming':
        cat = 1;
        break;
      case 'Expired':
        cat = 2;
        break;
      default:
        cat = null;
    }

    try {
      ConnectionStatusSingleton connectionStatus =
          ConnectionStatusSingleton.getInstance();

      bool isConnected = await connectionStatus.checkConnection();

      if (!isConnected) {
        print("is not connected");
        return PaginatedProducts.withError(
            errorMessage: 'Please check your internet connection.');
      }

      final response = await get(
          Uri.parse('${baseURL}videos?page=$page&cat=$cat'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${sharedPrefs.token}',
          });
      print(json.decode(response.body));
      return PaginatedProducts.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return PaginatedProducts.withError(
            errorMessage: 'Please check your internet connection.');
      } else {
        print(e.toString());
        return PaginatedProducts.withError(
            errorMessage: 'Something went wrong.');
      }
    }
  }

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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Container(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 16.0, left: 16.0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: SearchField(paginatorGlobalKey: paginatorGlobalKey)),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                      icon: Icon(Icons.filter_list,
                          size: 36, color: kPrimaryColor),
                      onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text("Search filter",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Chip(
                                          backgroundColor: kAccent,
                                          label: Text(searchCategory,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: kPrimaryColor)),
                                        ),
                                      ),
                                      FlatButton(
                                        child: Text("All"),
                                        textColor: kPrimaryColor,
                                        onPressed: () {
                                          setState(() {
                                            searchCategory = 'All';
                                          });
                                          paginatorGlobalKey.currentState
                                              .changeState(
                                                  pageLoadFuture:
                                                      fetchAdvertisements,
                                                  resetState: true);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Currently open"),
                                        textColor: kPrimaryColor,
                                        onPressed: () {
                                          setState(() {
                                            searchCategory = 'Currently open';
                                          });
                                          paginatorGlobalKey.currentState
                                              .changeState(
                                                  pageLoadFuture:
                                                      fetchAdvertisements,
                                                  resetState: true);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Upcoming"),
                                        textColor: kPrimaryColor,
                                        onPressed: () {
                                          setState(() {
                                            searchCategory = 'Upcoming';
                                          });
                                          paginatorGlobalKey.currentState
                                              .changeState(
                                                  pageLoadFuture:
                                                      fetchAdvertisements,
                                                  resetState: true);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Expired"),
                                        textColor: kPrimaryColor,
                                        onPressed: () {
                                          setState(() {
                                            searchCategory = "Expired";
                                          });
                                          paginatorGlobalKey.currentState
                                              .changeState(
                                                  pageLoadFuture:
                                                      fetchAdvertisements,
                                                  resetState: true);

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // backgroundColor: this._color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ))),
                ),
              ]),
              Container(
                height: MediaQuery.of(context).size.height * 0.685,
                width: double.infinity,
                child:
                    // ads.isEmpty
                    //     ? Center(
                    //         child: Text(
                    //             '        No items in 😩\nMaybe add items to? 🙄'))
                    //     : ListView.builder(
                    //         padding: EdgeInsets.zero,
                    //         shrinkWrap: true,
                    //         itemCount: ads.length,
                    //         physics: const BouncingScrollPhysics(
                    //             parent: AlwaysScrollableScrollPhysics()),
                    //         itemBuilder: (ctx, index) {
                    //           Advertisement a = ads[index];
                    //           //print(menu.getItemsByCategory(c.id));
                    //           return AdvertisementCard(a: a);
                    //         },
                    //       ),
                    Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.685,
                      width: double.infinity,
                      child: Paginator.listView(
                        key: paginatorGlobalKey,
                        pageLoadFuture: fetchAdvertisements,
                        pageItemsGetter: listItemsGetter,
                        listItemBuilder: listItemBuilder,
                        loadingWidgetBuilder: loadingWidgetMaker,
                        errorWidgetBuilder: errorWidgetMaker,
                        emptyListWidgetBuilder: emptyListWidgetMaker,
                        totalItemsGetter: totalPagesGetter,
                        pageErrorChecker: pageErrorChecker,
                        scrollPhysics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 1),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(20))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdvertisementCard extends StatelessWidget {
  const AdvertisementCard({
    Key key,
    @required this.a,
  }) : super(key: key);

  final Advertisement a;

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
            Hero(
              tag: a.id,
              child: Container(
                width: double.infinity,
                height: 200,
                child: FlatButton(
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   VideoDetailScreen.routeName,
                    //   arguments: ScreenArguments(a),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoDetailScreen(a: a)),
                    );
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
                decoration: BoxDecoration(
                  color: kAccent,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    image: NetworkImage(a.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Text(a.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w100)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Text('${a.offer_ends.replaceFirst(' ', '\n')}',
                      maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonColor,
                          fontSize: 12)),
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
                  child: Text(a.brand,
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
