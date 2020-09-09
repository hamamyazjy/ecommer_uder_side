import 'package:ecommer_user_side/ui/screens/cart_page.dart';
import 'package:ecommer_user_side/ui/screens/explore_page.dart';
import 'package:ecommer_user_side/ui/screens/search_screen.dart';
import 'package:ecommer_user_side/ui/widgets/custom_drawer.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

const String testDevice = '';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final MobileAdTargetingInfo targetInfo = MobileAdTargetingInfo(
    testDevices: <String>[testDevice],
    keywords: <String>['wommen', 'baby', 'men'],
    childDirected: true,
  );

  BannerAd banner;
  InterstitialAd interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print('Banner event: $event  ');
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print('Banner event: $event  ');
        });
  }

  int currentPage = 0;
// ca-app-pub-1464217446042225~6762889365
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    banner = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    banner.dispose();
    interstitialAd.dispose();
  }
  // List paages = [Explore(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey,
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.black),
          // automaticallyImplyLeading: false,

          elevation: 0,
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          // backgroundColor: Color(0xFF075C93),

          brightness: Brightness.light,
          title: Text(
            'Ecommer',
            style: TextStyle(
                fontSize: 16,
                // color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                      onTap: () {
                        createInterstitialAd()
                          ..load()
                          ..show();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SearchScreen(),
                        ));
                      },
                      child: Icon(
                        Icons.search,
                      )),
                ),
              ],
            ),
          ],
        ),
        body: Explore(),

        drawer: CustomDrawer(),
        // bottomNavigationBar: BottomNavigationBar(
        //     currentIndex: currentPage,
        //     onTap: (index) {
        //       setState(() {
        //         currentPage = index;
        //       });
        //     },
        //     items: [
        //       BottomNavigationBarItem(icon: Icon(Icons.home), title: Container()),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.shopping_cart), title: Container()),
        //     ]),

        // bottomNavigationBar: FancyBottomNavigation(
        //   initialSelection: currentPage,
        //   tabs: [
        //     TabData(iconData: Icons.home, title: "Home"),
        //     TabData(iconData: Icons.shopping_cart, title: "Basket"),
        //     TabData(iconData: Icons.account_circle, title: "Account")
        //   ],
        //   onTabChangedListener: (position) {
        //     currentPage = position;
        //     setState(() {});
        //   },
        // ),
      ),
    );
  }
}
