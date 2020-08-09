import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  String locationName;
  GoogleMapController controllerMap;
  LatLng flutterCoffee = LatLng(31.509557, 34.421466);

  double lat;
  double lng;

  Set<Marker> myMarkers = {
    Marker(
      markerId: MarkerId('flutterCoffee'),
      position: LatLng(31.509557, 34.421466),
    ),
  };

  AnimateCamera(LatLng location) {
    controllerMap.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
//            bearing: 30,
            tilt: 40,
            target: location,
            zoom: 13.2),
      ),
    );
    notifyListeners();
  }

  Future<LatLng> getCurrentLocation() async {
    geo.Geolocator geolocator = geo.Geolocator();
    geo.Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.low);
    LatLng myLocation = LatLng(position.latitude, position.longitude);
    AnimateCamera(myLocation);
    // print(myLocation);
    this.lat = position.latitude;
    this.lng = position.longitude;

    print(lat);
    notifyListeners();

    return myLocation;
  }

  getPlaceName(LatLng position) async {
    try {
      List<Address> addresses = await Geocoder.local
          .findAddressesFromCoordinates(
              Coordinates(position.latitude, position.longitude));
      Address first = addresses[0];
      locationName = first.addressLine;
      notifyListeners();
      print(locationName);
    } catch (e) {
      print(e);
    }
  }

  onTapMap(LatLng argument) async {
    myMarkers.toList().sublist(1, myMarkers.length).clear();
    // myMarkers.clear();
    myMarkers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: locationName),
        markerId: MarkerId('locationName'),
        position: LatLng(argument.latitude, argument.longitude),
      ),
    );
    await getPlaceName(argument);

    this.lat = argument.latitude;
    this.lng = argument.longitude;
    print(lng);
    notifyListeners();
  }

  onTapFloatingPoint() async {
    notifyListeners();
    await getCurrentLocation();
    LatLng myLocation = await getCurrentLocation();
    await getPlaceName(myLocation);
    AnimateCamera(myLocation);
    myMarkers.toList().sublist(1, myMarkers.length).clear();

    myMarkers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: locationName),
        markerId: MarkerId('locationName'),
        position: LatLng(myLocation.latitude, myLocation.longitude),
      ),
    );
  }
}
