import 'package:rocketelevatorsapp/networking/ApiProvider.dart';
import 'package:rocketelevatorsapp/models/Gmaps.dart';
import 'dart:async';

class GmapsRepository {
  ApiProvider _provider = ApiProvider();

  Future<Location> getLocation(id) async {
    print("Location finally triggered as well ; $id");
    final response = await _provider.get("elevators/location/$id");
    print("Address Id : $id");
    print("Location Response : $response");
    Location location;
    location = await response
        .map<Location>((json) => Location.fromJson(json));
    print("I'M HERE : $Location and response : $response");
    return location;
  }
}
