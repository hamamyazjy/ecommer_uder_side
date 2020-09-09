import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/ui/screens/cart_page.dart';
import 'package:ecommer_user_side/ui/screens/edit_profile_screen.dart';
import 'package:ecommer_user_side/ui/screens/home_screen.dart';
import 'package:ecommer_user_side/ui/screens/login_screen.dart';
import 'package:ecommer_user_side/ui/screens/my_orders.dart';
import 'package:ecommer_user_side/ui/screens/setting_page.dart';
import 'package:ecommer_user_side/ui/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'custom_dialog.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);

    return Drawer(
      child: Column(
        children: <Widget>[
          Consumer<AuthProvider>(
            builder: (BuildContext context, AuthProvider value, Widget child) {
              if (value.uId != null) {
                return FutureBuilder<List<String>>(
                  future:
                      Provider.of<AuthProvider>(context).getInformationUser(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List<String> information = snapshot.data;

                      if (information.length > 0) {
                        return UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: Color(0xFF075C93),
                          ),
                          currentAccountPicture: CircleAvatar(
                            child: information[1] == null
                                ? Text(
                                    '${information[0][0].toUpperCase()}',
                                    style: TextStyle(fontSize: 60),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: information[1],
                                      // imageUrl:
                                    ),
                                  ),
                            maxRadius: 50,
                          ),
                          accountName: Text(
                            '${information[2][0].toUpperCase() + information[2].substring(1)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              // color: Color(0xff000000),
                            ),
                          ),
                          accountEmail: Text(
                            information[0],
                            style: TextStyle(
                              fontSize: 15,
                              // color: Color(0xff000000),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('Please Login '),
                        );
                      }
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 50.0,
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Text('Please Login '),
                );
              }
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Container(
                      height: 40.00,
                      width: 40.00,
                      decoration: BoxDecoration(
                        color: Color(0xFF075C93).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4.00),
                      ),
                      child: Icon(Icons.home),
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: Color(0xFF075C93).withOpacity(0.9),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CartScreen(context)));
                  },
                  child: ListTile(
                    leading: Container(
                      height: 40.00,
                      width: 40.00,
                      decoration: BoxDecoration(
                        color: Color(0xFF075C93).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4.00),
                      ),
                      child: Icon(Icons.shopping_cart),
                    ),
                    title: Text(
                      "My Cart",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: Color(0xFF075C93).withOpacity(0.9),
                    ),
                  ),
                ),
                FutureBuilder<String>(
                  future: Provider.of<AuthProvider>(context).getUid(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return Center(
                          child: Container(),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            custonDialog(
                                title: 'Warning !!',
                                description: 'You Sure to Sign Out',
                                context: context,
                                onYes: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .signOut();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignIn()));
                                },
                                onNo: () {
                                  Navigator.pop(context);
                                });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditProfileScreen()));
                            },
                            child: ListTile(
                              leading: Container(
                                height: 40.00,
                                width: 40.00,
                                decoration: BoxDecoration(
                                  color: Color(0xFF075C93).withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(4.00),
                                ),
                                child: Icon(Icons.edit),
                              ),
                              title: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 16,
                                  // color: Color(0xff000000),
                                ),
                              ),
                              trailing: Icon(Icons.navigate_next,
                                  color: Color(0xFF075C93).withOpacity(0.9)),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                FutureBuilder<String>(
                  future: Provider.of<AuthProvider>(context).getUid(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return Center(
                          child: Container(),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyOrders()));
                          },
                          child: ListTile(
                            leading: Container(
                              height: 40.00,
                              width: 40.00,
                              decoration: BoxDecoration(
                                color: Color(0xFF075C93).withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4.00),
                              ),
                              child: Icon(Icons.shopping_basket),
                            ),
                            title: Text(
                              "My Orders",
                              style: TextStyle(
                                fontSize: 16,
                                // color: Color(0xff000000),
                              ),
                            ),
                            trailing: Icon(Icons.navigate_next,
                                color: Color(0xFF075C93).withOpacity(0.9)),
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => WishlistScreen()));
                  },
                  child: ListTile(
                    leading: Container(
                      height: 40.00,
                      width: 40.00,
                      decoration: BoxDecoration(
                        color: Color(0xFF075C93).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4.00),
                      ),
                      child: Icon(Icons.favorite_border),
                    ),
                    title: Text(
                      "Wishlist",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(Icons.navigate_next,
                        color: Color(0xFF075C93).withOpacity(0.9)),
                  ),
                ),
                FutureBuilder<String>(
                  future: Provider.of<AuthProvider>(context).getUid(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return Center(
                          child: Container(),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            custonDialog(
                                title: 'Warning !!',
                                description: 'You Sure to Sign Out',
                                context: context,
                                onYes: () {
                                  Navigator.pop(context);
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .signOut();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SignIn()));
                                },
                                onNo: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                          },
                          child: ListTile(
                            leading: Container(
                              height: 40.00,
                              width: 40.00,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4.00),
                              ),
                              child: Icon(Icons.settings_power),
                            ),
                            title: Text(
                              "Sign Out",
                              style: TextStyle(
                                fontSize: 16,
                                // color: Color(0xff000000),
                              ),
                            ),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.red.withOpacity(0.7),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SettingsPage()));
                  },
                  child: ListTile(
                    leading: Container(
                      height: 40.00,
                      width: 40.00,
                      decoration: BoxDecoration(
                        color: Color(0xFF075C93).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4.00),
                      ),
                      child: Icon(Icons.edit),
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(Icons.navigate_next,
                        color: Color(0xFF075C93).withOpacity(0.9)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
