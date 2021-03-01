import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        appBar: AppBar(
            actions: <Widget>[CircleAvatar(radius: 16), SizedBox(width: 16)]),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              AdvertisementFeed(),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.blue,
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
              Container(
                height: MediaQuery.of(context).size.height * 0.63,
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
                                          // Navigator.pushNamed(
                                          //     context, ItemScreen.routeName);
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
                                                fontWeight: FontWeight.bold, color: buttonColor)),
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
