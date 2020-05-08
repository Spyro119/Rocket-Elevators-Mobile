import 'package:rocketelevatorsapp/networking/ApiProvider.dart';
import 'package:rocketelevatorsapp/models/elevatorResponse.dart';
import 'dart:async';

class ElevatorsRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<ElevatorsResponse>> fetchElevators() async {
    final response = await _provider.get("elevators/inactiveelevators");
    List<ElevatorsResponse> elevators;
    elevators = await response.map<ElevatorsResponse>((json) => ElevatorsResponse.fromJson(json)).toList();
    return elevators;
  }


  Future<ElevatorsResponse> putElevators(dynamic elevators) async {
    ElevatorsResponse Elevators;
    dynamic headers = {"Content-type": "application/json"};
    dynamic jsonStr = elevators.toJson();
    await _provider.put('elevators/${elevators.id}', elevators,  headers, jsonStr);
    return Elevators;
  }
}