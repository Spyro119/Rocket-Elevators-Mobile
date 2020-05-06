import 'package:rocketelevatorsapp/networking/ApiProvider.dart';
import 'package:rocketelevatorsapp/models/elevatorResponse.dart';
import 'dart:async';

class EmployeesRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<ElevatorsResponse>> fetchElevators() async {
    final response = await _provider.get("elevators");
    List<ElevatorsResponse> Elevators;
    Elevators = await response.map<ElevatorsResponse>((json) => ElevatorsResponse.fromJson(json)).toList();
    print(Elevators[0].id);
    return Elevators;
  }
}