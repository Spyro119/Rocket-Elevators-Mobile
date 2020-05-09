import 'package:rocketelevatorsapp/networking/CustomException.dart';
import 'package:rocketelevatorsapp/models/elevatorResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

// Base "url", make the API calls functions dynamic. Contains domain and
// sub-domain url.
class ApiProvider {
  final String _baseUrl =
      "https://rocketelevatorsrestapisj.azurewebsites.net/api/";

  // Single function for all GET request with get('url'). "API pathing"
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print(responseJson.runtimeType);
    return responseJson;
  }

  Future<dynamic> put(String url, ElevatorsResponse elevators,
      Map<String, dynamic> headers, Map<String, dynamic> jsonStr) async {
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url,
          headers: headers, body: json.encode(jsonStr));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        Iterable responseJson = json.decode(response.body);
//        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
