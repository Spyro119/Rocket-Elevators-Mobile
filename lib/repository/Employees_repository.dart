import 'package:rocketelevatorsapp/networking/ApiProvider.dart';
import 'package:rocketelevatorsapp/models/employeeResponse.dart';
import 'dart:async';

class EmployeesRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<EmployeeResponse>> fetchEmployees() async {
    final response = await _provider.get("employees");
//    print(response.runtimeType);
//    print(response[1].runtimeType);
    List<EmployeeResponse> Employees;
    Employees = await response
        .map<EmployeeResponse>((json) => EmployeeResponse.fromJson(json))
        .toList();
//     Employees = new EmployeesList.fromJson(response);
//     print(Employees[1].email);
    print(Employees[0].email);
    return Employees;
  }
}
