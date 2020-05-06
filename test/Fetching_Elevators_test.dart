import 'package:rocketelevatorsapp/models/ElevatorResponse.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

void main() {
  group('Testing Json decoding', () {
    test('Should return an object', () {
      var f = {
        "id":1,
        "building_type":"Residential",
        "elevator_serial_number":550010719,
        "elevator_model":"Premium",
        "elevator_status":"Active",
        "elevator_information":"old",
        "column_id":1};
      f.toString();
      expect(ElevatorsResponse.fromJson(f), isA<ElevatorsResponse>());
    });
  });
  group('Testing model\'s creation', () {
    test('Should have access to Object\'s properties', () {
      ElevatorsResponse Elevators = new ElevatorsResponse(id: 2,
          buildingType: "Residential",
          elevatorSerialNumber:550010719,
          elevatorModel: "Premium",
          elevatorStatus:"Active",
          elevatorInformation:"old",
          columnId: 1
      );
//      expect(Elevators.firstname == 'Samuel', true);
    });
  });
  group('Testing Json object properties', () {
    test('Should have access to the properties', () {
      var f = {
        "id":1,
        "building_type":"Residential",
        "elevator_serial_number":550010719,
        "elevator_model":"Premium",
        "elevator_status":"Active",
        "elevator_information":"old",
        "column_id":1
      };
      f.toString();
      ElevatorsResponse Elevator = ElevatorsResponse.fromJson(f);
//      expect(Elevator.id, "Eliseo");
    });
  });
  group('Testing Json object Elevator properties', () {
    test('Should have access to the properties', () {
      List F;
      F = [{
          "id":1,
          "building_type":"Residential",
          "elevator_serial_number":550010719,
          "elevator_model":"Premium",
          "elevator_status":"Active",
          "elevator_information":"old",
          "column_id":1
      },
        {
        "id":2,
      "building_type":"Corporate","elevator_serial_number":134309379,
      "elevator_model":"Premium","elevator_status":"Intervention",
      "elevator_information":"in service since 4 years",
      "column_id":1
      },
      {
        "id":3,
        "building_type":"Commercial",
      "elevator_serial_number":398284927,
      "elevator_model":"Premium",
      "elevator_status":"Inactive",
      "elevator_information":"Brand new",
      "column_id":1
      }];
      F.toString();
      List<ElevatorsResponse> Elevators;
      Elevators = F.map<ElevatorsResponse>((json) => ElevatorsResponse.fromJson(json)).toList();
      expect(Elevators[1].id, isA<int>());
    });
  });
}