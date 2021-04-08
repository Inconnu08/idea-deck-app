import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea_deck/screens/profile.dart';
import 'package:idea_deck/screens/video_details.dart';

import '../constants.dart';
import '../models/ads.dart';
import '../size_config.dart';
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
              Container(
                height: MediaQuery.of(context).size.height * 0.685,
                width: double.infinity,
                child: ads.isEmpty
                    ? Center(
                        child: Text(
                            '        No items in 😩\nMaybe add items to? 🙄'))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: ads.length,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (ctx, index) {
                          Advertisement a = ads[index];
                          //print(menu.getItemsByCategory(c.id));
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
                                          Navigator.pushNamed(context,
                                              VideoDetailScreen.routeName);
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
                                      decoration: BoxDecoration(
                                        color: kAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        image: DecorationImage(
                                          image: NetworkImage(a.thumbnail),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, left: 16.0, right: 16.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.1,
                                        child: Text(a.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w100)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, left: 16.0, right: 16.0),
                                        child: Text('${a.offerEnds}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: buttonColor)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                            left: 16.0,
                                            right: 16.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.1,
                                        child: Text(a.brand,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                color: Colors.grey)),
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
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
