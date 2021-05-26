import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:u_go/configMaps.dart';
import 'package:u_go/constants.dart';
import 'package:u_go/data%20handlers/app_data.dart';
import 'package:u_go/models/address.dart';
import 'package:u_go/screens/searchScreen.dart';

class DashBoard extends StatefulWidget {
  static String screenID = 'dashboard_screen';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController _newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentUserPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;

  void locateUserPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentUserPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(
      target: latLngPosition,
      zoom: 14.0,
    );
    _newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Address pickUpAddress = new Address(
      latitude: position.latitude,
      longitude: position.longitude,
      placeFormattedAddress: "",
      name: placemarks[0].name,
      street: placemarks[0].street,
      pin: placemarks[0].postalCode,
      area1: placemarks[0].administrativeArea,
      area2: placemarks[0].subAdministrativeArea,
      locality1: placemarks[0].locality,
      locality2: placemarks[0].subLocality,
      thoroughfare1: placemarks[0].thoroughfare,
      thoroughfare2: placemarks[0].subThoroughfare,
    );
    Provider.of<AppData>(context, listen: false).updatePickUpAddress(pickUpAddress);
    // Fluttertoast.showToast(msg: placemarks[0].name);
    for(Placemark i in placemarks) print("///////////////////////////////////////////////////////////////////////////////////////////////////////\n$i\n/////////////////////////////////////////");
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: kBackgroundColor,
        drawer: Container(
          color: kThemePrimary,
          width: 255.0,
          child: Drawer(
            child: ListView(
              children: [
                Container(
                  height: 165.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abhishek Saini',
                              style: GoogleFonts.notoSans(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "86 miles",
                              style: GoogleFonts.notoSans(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: kBackgroundColor,
                  ),
                  title: Text(
                    'My Account',
                    style: GoogleFonts.notoSans(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.history_outlined,
                    color: kBackgroundColor,
                  ),
                  title: Text(
                    'History',
                    style: GoogleFonts.notoSans(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: kBackgroundColor,
                  ),
                  title: Text(
                    'About',
                    style: GoogleFonts.notoSans(
                      fontSize: 15.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                GoogleMap(
                  padding: EdgeInsets.only(
                    bottom: bottomPaddingOfMap,
                  ),
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController.complete(controller);
                    _newGoogleMapController = controller;
                    locateUserPosition();
                    setState(() {
                      bottomPaddingOfMap = 305.0;
                    });
                  },
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                ),

                //HamBurger Button to open Drawer
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            )
                          ]),
                      child: CircleAvatar(
                        backgroundColor: kBackgroundColor,
                        child: Icon(
                          Icons.menu_outlined,
                          color: Colors.white,
                        ),
                        radius: 20.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: kThemePrimary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 16.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            'Hi there',
                            style: GoogleFonts.notoSans(
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'Where to',
                            style: GoogleFonts.notoSans(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SearchScreen.screenId);
                            },
                            child: Hero(
                              tag: 'search_destination_textfield_box',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: kBackgroundColor,
                                  //     blurRadius: 6.0,
                                  //     spreadRadius: 0.5,
                                  //     offset: Offset(0.7, 0.7),
                                  //   ),
                                  // ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter Destination',
                                    hintStyle: GoogleFonts.notoSans(
                                      fontSize: 14.0,
                                      color: kBackgroundColor
                                    ),
                                    enabled: false,
                                    border: InputBorder.none,
                                    fillColor: Colors.grey.withOpacity(0.5),
                                    prefixIcon: Icon(
                                      Icons.search_outlined,
                                      color: kBackgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 0.0),
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.home_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Provider.of<AppData>(context).pickUpLocation != null
                                          ? Provider.of<AppData>(context).pickUpLocation.street
                                          : 'Add Home',
                                          style: GoogleFonts.notoSans(),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          'Your living home address',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.work_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Add Work',
                                          style: GoogleFonts.notoSans(),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          'Your working office address',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
