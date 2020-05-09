import 'package:rocketelevatorsapp/models/employeeResponse.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

void main() {
  group('Testing Json decoding', () {
    test('Should return an object', () {
      var f = {
        "id": 1,
        "firstname": "Eliseo",
        "lastname": "Carroll",
        "function": "Customer Government Manager",
        "email": "nenita@bartellcrooks.name",
        "aiProfile": "c408b390-3947-46cb-8975-e41ffc14ad8a"
      };
      f.toString();
      expect(EmployeeResponse.fromJson(f), isA<EmployeeResponse>());
      List F;
      F = [
        {
          "id": 1,
          "firstname": "Eliseo",
          "lastname": "Carroll",
          "function": "Customer Government Manager",
          "email": "nenita@bartellcrooks.name",
          "aiProfile": "c408b390-3947-46cb-8975-e41ffc14ad8a"
        },
        {
          "id": 2,
          "firstname": "Alfonzo",
          "lastname": "Wisozk",
          "function": "Future Mining Developer",
          "email": "enoch_prosacco@mills.info",
          "aiProfile": null
        }
      ];
      F.toString();
      EmployeesList Employees = new EmployeesList.fromJson(F);
      expect(Employees, isA<EmployeesList>());
    });
  });
  group('Testing model\'s creation', () {
    test('Should have access to Object\'s properties', () {
      EmployeeResponse Employee = new EmployeeResponse(
          id: 2,
          firstname: 'Samuel',
          lastname: 'Jubinville-Baril',
          function: 'ceo',
          email: 'Samuel@codeboxx.biz',
          aiProfile: null);
      expect(Employee.firstname == 'Samuel', true);
    });
  });
  group('Testing Json object properties', () {
    test('Should have access to the properties', () {
      var f = {
        "id": 1,
        "firstname": "Eliseo",
        "lastname": "Carroll",
        "function": "Customer Government Manager",
        "email": "nenita@bartellcrooks.name",
        "aiProfile": "c408b390-3947-46cb-8975-e41ffc14ad8a"
      };
      f.toString();
      EmployeeResponse employee = EmployeeResponse.fromJson(f);
      expect(employee.firstname, "Eliseo");
    });
  });
  group('Testing Json object properties', () {
    test('Should have access to the properties', () {
      List F;
      F = [
        {
          "id": 1,
          "firstname": "Eliseo",
          "lastname": "Carroll",
          "function": "Customer Government Manager",
          "email": "nenita@bartellcrooks.name",
          "aiProfile": "c408b390-3947-46cb-8975-e41ffc14ad8a"
        },
        {
          "id": 2,
          "firstname": "Alfonzo",
          "lastname": "Wisozk",
          "function": "Future Mining Developer",
          "email": "enoch_prosacco@mills.info",
          "aiProfile": null
        }
      ];
      F.toString();
      List<EmployeeResponse> Employees;
//    for(var f in response){
      Employees = F
          .map<EmployeeResponse>((json) => EmployeeResponse.fromJson(json))
          .toList();
      expect(Employees[1].email, isA<String>());
    });
  });
}
