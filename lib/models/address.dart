class Address {
  String placeFormattedAddress;
  String name;
  String street;
  String pin;
  String area1;
  String area2;
  String locality1;
  String locality2;
  String thoroughfare1;
  String thoroughfare2;
  double latitude;
  double longitude;
  String placeID;

  Address({
    this.placeFormattedAddress,
    this.name,
    this.street,
    this.pin,
    this.area1,
    this.area2,
    this.locality1,
    this.locality2,
    this.thoroughfare1,
    this.thoroughfare2,
    this.latitude,
    this.longitude,
    this.placeID
});

  void formatAddress() {
    this.placeFormattedAddress =
    this.name +
    this.street +
    this.pin +
    this.area1 +
    this.area2 +
    this.locality1 +
    this.locality2 +
    this.thoroughfare1 +
    this.thoroughfare2;
  }

  String getPlaceFormattedAddress() {
    return this.placeFormattedAddress;
  }
}