import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:u_go/configMaps.dart';
import 'package:u_go/data%20handlers/app_data.dart';
import 'package:u_go/helper/request_url.dart';
import 'package:u_go/models/address.dart';
import 'package:u_go/models/placePredictions.dart';
import 'package:u_go/screens/divider.dart';
import 'package:u_go/constants.dart';

class SearchScreen extends StatefulWidget {
  static String screenId = 'search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).pickUpLocation.street;
    pickUpTextEditingController.text = placeAddress;

    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Column(
            children: [
              Container(
                height: 225.0,
                decoration: BoxDecoration(
                  color: kThemePrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Center(
                            child: Text(
                              'Set Drop Off',
                              style: GoogleFonts.notoSans(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: pickUpTextEditingController,
                          onChanged: (val) {
                            findPlace(val);
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Pickup Location',
                            hintStyle: GoogleFonts.notoSans(
                              fontSize: 14.0,
                              color: kBackgroundColor,
                            ),
                            border: InputBorder.none,
                            fillColor: Colors.grey.withOpacity(0.5),
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Hero(
                        tag: 'search_destination_textfield_box',
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: dropOffTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Enter Destination',
                              hintStyle: GoogleFonts.notoSans(
                                fontSize: 14.0,
                                color: kBackgroundColor,
                              ),
                              border: InputBorder.none,
                              fillColor: Colors.grey.withOpacity(0.5),
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              (placePredictionList.length > 0)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: ListView.separated(
                          padding: EdgeInsets.all(0.0),
                          itemBuilder: (context, index) {
                            return _buildListItem(
                              placePredictions: placePredictionList[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => CustomDivider(),
                          itemCount: placePredictionList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),

                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String path =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapAPIKey&sessiontoken=1234567890&components=country:in';
      Uri url = new Uri(path: path);
      var res = await RequestURL.getRequest(url);

      if (res == 'Failed') {
        return;
      }
      print(res);

      if (res['status'] == 'OK') {
        var predictions = res['predictions'];
        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJason(e))
            .toList();
        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }
}

class _buildListItem extends StatelessWidget {
  final PlacePredictions placePredictions;

  _buildListItem({this.placePredictions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSans(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSans(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeID, context) async {
    String path = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&fields=name,rating,formatted_phone_number&key=$mapAPIKey';
    Uri url = new Uri(path: path);
    var res = await RequestURL.getRequest(url);

    if(res == 'Failed') {
      return;
    }
    if(res['status']=='OK') {
      Address address = Address(
        name: res['result']['name'],
        placeID: res['result'][placeID],
          latitude: res['result']['geometry']['locatio']['lat'],
          longitude: res['result']['geometry']['locatio']['lng'],
      );

      Provider.of<AppData>(context, listen: false).updatePickUpAddress(address);
      Navigator.pop(context);
      print('DROP OFF LOCATION SET SUCCESSFULLY');
    }
  }
}
