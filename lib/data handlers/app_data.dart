import 'package:flutter/cupertino.dart';
import 'package:u_go/models/address.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation;
  Address dropOffLocation;
  void updatePickUpAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    pickUpLocation.formatAddress();
    notifyListeners();
  }

  void updateDropOffAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    dropOffLocation.formatAddress();
    notifyListeners();
  }
}