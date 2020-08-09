import 'package:ecommer_user_side/ui/screens/cart_page.dart';
import 'package:ecommer_user_side/ui/screens/explore_page.dart';
import 'package:ecommer_user_side/ui/screens/search_screen.dart';
import 'package:ecommer_user_side/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  // List paages = [Explore(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          // automaticallyImplyLeading: false,

          elevation: 0,
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          backgroundColor: Color(0xFF075C93),
           brightness: Brightness.light,
          title: Text(
            'Ecommer',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                      onTap: () {
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
