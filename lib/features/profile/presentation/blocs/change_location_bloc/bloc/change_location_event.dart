abstract class ChangeLocationEvent {}

class CountryChanged extends ChangeLocationEvent {
  final String country;
  CountryChanged(this.country);
}

class CityChanged extends ChangeLocationEvent {
  final String city;
  CityChanged(this.city);
}

class ZipChanged extends ChangeLocationEvent {
  final String zip;
  ZipChanged(this.zip);
}

class AddressChanged extends ChangeLocationEvent {
  final String address;
  AddressChanged(this.address);
}

class UpdateLocation extends ChangeLocationEvent {}
