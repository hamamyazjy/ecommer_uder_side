import 'package:ecommer_user_side/provider/card_provider.dart';
import 'package:ecommer_user_side/provider/map_provider.dart';
import 'package:ecommer_user_side/ui/screens/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class GoogleMapExample extends StatelessWidget {
  GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: keyScaffold,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: GoogleMap(
                onMapCreated: (controller) async {
                  Provider.of<MapProvider>(context, listen: false)
                      .controllerMap = controller;
                },
                onTap: (argument) {
                  Provider.of<MapProvider>(context, listen: false)
                      .onTapMap(argument);
                },
                markers: {
                  ...?Provider.of<MapProvider>(context).myMarkers,
                },
                initialCameraPosition: CameraPosition(
                  target: Provider.of<MapProvider>(context, listen: false)
                      .flutterCoffee,
                  zoom: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    String locationName =
                        Provider.of<MapProvider>(context, listen: false)
                            .locationName;

                    if (locationName == null) {
                      keyScaffold.currentState.showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please select location'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {
                            keyScaffold.currentState..removeCurrentSnackBar();
                          },
                        ),
                      ));
                    } else {
                      await Provider.of<CardProvider>(context, listen: false)
                          .deleteAllProductFormSqlAndAddToOrderFireStore(
                              Provider.of<MapProvider>(context, listen: false)
                                  .locationName);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => MyOrders()));
                    }
                  },
                  child: Container(
                    height: 40.0,
                    width: 200,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'Buy',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Location l = Location();

            bool _sericeEnabled = await l.serviceEnabled();
            if (_sericeEnabled) {
              Provider.of<MapProvider>(context, listen: false)
                  .onTapFloatingPoint();
            } else {
              _sericeEnabled = await l.requestService();
              if (_sericeEnabled) {
                Provider.of<MapProvider>(context, listen: false)
                    .onTapFloatingPoint();
              } else {
                SystemNavigator.pop();
              }
            }
          },
          tooltip: 'add',
          child: Icon(FontAwesomeIcons.locationArrow),
        ),
      ),
    );
  }
}
