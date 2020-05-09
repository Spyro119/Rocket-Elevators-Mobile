import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class Location {
  int id;
  String city;
  String addressType;
  String addressStatus;
  String streetNumber;
  String streetName;
  String suiteOrApartment;
  String postalCode;
  String entityType;
  int entityId;
  double latitude;
  double longitude;

  Location(
      {this.id,
        this.city,
        this.addressType,
        this.addressStatus,
        this.streetNumber,
        this.streetName,
        this.suiteOrApartment,
        this.postalCode,
        this.entityType,
        this.entityId,
        this.latitude,
        this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    print('Location.fromJson triggerd too');
    return new Location(
    id: json['id'],
    city: json['city'],
    addressType: json['address_type'],
    addressStatus:  json['address_status'],
    streetNumber: json['street_number'],
    streetName: json['street_name'],
    suiteOrApartment: json['suite_or_apartment'],
    postalCode: json['postal_code'],
    entityType: json['entity_type'],
    entityId: json['entity_id'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    );
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['city'] = this.city;
//    data['address_type'] = this.addressType;
//    data['address_status'] = this.addressStatus;
//    data['street_number'] = this.streetNumber;
//    data['street_name'] = this.streetName;
//    data['suite_or_apartment'] = this.suiteOrApartment;
//    data['postal_code'] = this.postalCode;
//    data['entity_type'] = this.entityType;
//    data['entity_id'] = this.entityId;
//    data['latitude'] = this.latitude;
//    data['longitude'] = this.longitude;
//    return data;
//  }
}


//Future<Location> getGoogleOffices() async {
//  const googleLocationsURL = 'https://about.google/static/data/locations.json';
//
//  // Retrieve the locations of Google offices
//  final response = await http.get(googleLocationsURL);
//  if (response.statusCode == 200) {
//    return Location.fromJson(json.decode(response.body));
//  } else {
//    throw HttpException(
//        'Unexpected status code ${response.statusCode}:'
//            ' ${response.reasonPhrase}',
//        uri: Uri.parse(googleLocationsURL));
//  }
//}