import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/provider/card_provider.dart';
import 'package:ecommer_user_side/provider/map_provider.dart';
import 'package:ecommer_user_side/provider/order_provider.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:ecommer_user_side/provider/filter_provider.dart';
import 'package:ecommer_user_side/ui/screens/home_screen.dart';

import 'package:ecommer_user_side/ui/screens/login_screen.dart';
import 'package:ecommer_user_side/ui/screens/on_boarding.dart';
import 'package:ecommer_user_side/ui/screens/splash_screens.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper/shared_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isSeen = await ShaerdHelper.sHelper.getValueisSeen();
  bool isSeenOnBoarding = await ShaerdHelper.sHelper.getValueisSeenOnBoarding();

  Widget screen;

  if (isSeenOnBoarding == false || isSeenOnBoarding == null) {
    screen = OnBording();
  } else if (isSeen == false || isSeen == null) {
    screen = SignIn();
  } else {
    screen = HomeScreen();
  }
  runApp(MyApp(screen: screen));
}

class MyApp extends StatelessWidget {
  final Widget screen;
  MyApp({this.screen});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<CardProvider>(
          create: (context) => CardProvider(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider<MapProvider>(
          create: (context) => MapProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreens(screen: screen),
      ),
    );
  }
}
