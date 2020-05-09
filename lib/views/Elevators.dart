import 'package:flutter/material.dart';
import 'package:rocketelevatorsapp/repository/Elevators_repository.dart';
import 'package:rocketelevatorsapp/models/elevatorResponse.dart';
import 'package:rocketelevatorsapp/views/Gmaps.dart';
import 'package:rocketelevatorsapp/models/Gmaps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

ElevatorsRepository repo = new ElevatorsRepository();
Completer<GoogleMapController> _controller = Completer();

class ElevatorsModel {
  final StreamController<List<ElevatorsResponse>> _elevatorsController =
      StreamController<List<ElevatorsResponse>>.broadcast();
  Stream<List<ElevatorsResponse>> get elevatorStatus =>
      _elevatorsController.stream;

  void dispose() {
    _elevatorsController.close();
  }
}

class Elevators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text('Elevators'), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              })
        ]),
        body: StreamBuilder(
            stream: getElevators(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Scaffold(
                    body: Center(child: Text("Error : ${snapshot.error}")));
              if (snapshot.hasData) {

                print('Data found? ${snapshot.hasData}');

                return elevatorList(context, snapshot.data);
              } else {
                print('no data found. $snapshot and ${snapshot.hasData}');
                return loadingScreen(context);
              }
            }));
  }
}

Stream<List<ElevatorsResponse>> getElevators() async* {

  List<ElevatorsResponse> elevators = await repo.fetchElevators();
  yield elevators;
}

Widget elevatorList(BuildContext context, List<ElevatorsResponse> elevators) {
  return Scaffold(
    body: new Center(
      child: new Wrap(children: [
        new Container(
          child: Text(
              'there are currently ${elevators.length} inactive elevators.\n '
              'Swipe up and press any elevator\'s button. '),
        ),
      Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.end,
                    spacing: 10.0,
                    children: _buildButtonsWithNames(context, elevators))
      ]),
    ),
  );
}

Future<Location> getMaps(id) async {
    Location location = await getLocation(id);

  return location;
}

Future<Widget> buildMap(context, id) async {
  print('BUILDING MAPS');
  Location locations = await getMaps(id);
  print("Location here : $locations");
  final Map<String, Marker> _markers = {};

      double lat = locations.latitude;
      double lng = locations.longitude;
      final marker = Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
        snippet: locations.city,
      ),
    );
//    _markers['elevators # ' + elevators.id] = marker;

    Widget gmaps = GoogleMap(
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
        initialCameraPosition: CameraPosition(
            target: LatLng(lat, lng),
            zoom: 15
        ),
        markers: _markers.values.toSet(),
        );
    print(gmaps);
  return gmaps;
}

List<Widget> _buildButtonsWithNames(context, elevators) {
  List<RaisedButton> buttonsList = new List<RaisedButton>();

  for (int i = 1; i < elevators.length; i++) {
    String id = elevators[i].id.toString();
    String status = elevators[i].elevatorStatus.toString();
    buttonsList.add(new RaisedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(overflow: Overflow.visible, children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Text('Elevator\'s ID : ${elevators[i].id} \n '
                        'Elevator\'s building type : ${elevators[i].buildingType} \n'
                        'Elevator\'s serial number : ${elevators[i].elevatorSerialNumber}\n'
                        'Elevator\'s model : ${elevators[i].elevatorModel}\n'
                        'Elevator\'s status : ${elevators[i].elevatorStatus}\n'
                        'Elevator\'s information : ${elevators[i].elevatorInformation}'),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton.icon(
                        color: elevators[i].elevatorStatus == 'active'
                            ? Colors.green
                            : Colors.red,
                        onPressed: () {
                          ElevatorsResponse elevator = new ElevatorsResponse(
                              id: elevators[i].id,
                              buildingType: elevators[i].buildingType,
                              elevatorModel: elevators[i].elevatorModel,
                              elevatorStatus: elevators[i].elevatorStatus,
                              elevatorInformation:
                                  elevators[i].elevatorInformation,
                              elevatorSerialNumber:
                                  elevators[i].elevatorSerialNumber,
                              columnId: elevators[i].columnId);

                          elevator.elevatorStatus = 'active';
                          print(elevator.elevatorStatus);
                          repo.putElevators(elevator);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Elevators()));
                        },
                        label: Text(elevators[i].elevatorStatus == 'active'
                            ? 'elevator\'s status \n'
                                'is already active'
                            : 'Change elevator\'s \n'
                                ' status to '
                                'active'),
                        icon: Icon(
                          Icons.send,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: buildMap(context, elevators[i].id),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Positioned(
                              bottom: 100,
                              left: 60,
                              width: 200, // or use fixed size like 200
                              height: 200,
                              child: snapshot.data,
                            );
                          }
                          else {
                            return Positioned(
                                bottom: 100,
                                left: 60,
                                height: 60,
                                width: 60,
                                child: loadingScreen(context),
                            );
                          }
                        }),
                  ]),
                );
              });
        },
        color: Colors.blue,
        child: Text('Elevators : $id status: $status')));
  }
  return buttonsList;
}

Widget loadingScreen(context) {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}