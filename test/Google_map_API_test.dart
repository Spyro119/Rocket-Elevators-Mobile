import 'package:flutter_test/flutter_test.dart';
import 'package:rocketelevatorsapp/views/Gmaps.dart';
import 'package:rocketelevatorsapp/models/Gmaps.dart';
import 'package:rocketelevatorsapp/views/Elevators.dart';

void main() {
  group('Trying to fetch Gmaps', () {
    test('should return a "location" object', () {
      Future<Location> location =  getLocation(21);
      expect(location, isA<Future<Location>>());
    });
  });
  group('Trying to fetch Gmaps', () {
    test('should return a "location" object', () {
      Future<Location> getLocation() async {
        Location location = await getMaps(22);
        print(location.city);
        return location;
      }
      Future<Location> loc = getLocation();

      expect(loc, isA<Future<Location>>());
    });
  });
}
