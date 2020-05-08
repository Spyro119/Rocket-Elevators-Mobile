import 'package:flutter/material.dart';
import 'package:rocketelevatorsapp/repository/Elevators_repository.dart';
import 'package:rocketelevatorsapp/models/elevatorResponse.dart';
import 'dart:async';

//for debugging
//void main() => runApp(Elevators());

class Elevators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getElevators(),
      initialData: "Loading Elevators...",
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return Center(child: Text("Error : ${snapshot.error}"));
        while (!snapshot.hasData ){
          print(snapshot.hasData);
          return Center(child: Text(" Waiting to fetch elevators"));
        }
        if (snapshot.hasData) {
          print('Data found. ${snapshot.hasData}');
          return elevatorList(context, snapshot.data);
        } else {
          print('no data found. $snapshot and ${snapshot.hasData}');
          return CircularProgressIndicator();
        }
      });
  }
}

Future<dynamic> getElevators() async {
  print('triggered');
  dynamic elevator = new ElevatorsRepository();
  List<ElevatorsResponse> elevators = await elevator.fetchElevators();
  print('elevators Type : ${elevators.runtimeType}, can call ID? ${elevators.first.id}');
  return elevators;
}

Widget elevatorList(BuildContext context, elevators) {
  return Scaffold(
    appBar: AppBar(
        title: Text('Elevators'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              }
          )
        ]
    ),
    body:
        Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            spacing: 10.0,
            children: _buildButtonsWithNames(context, elevators)
        )
  );
}

List<Widget> _buildButtonsWithNames(context, elevators) {
  List<RaisedButton> buttonsList = new List<RaisedButton>();
//  while (elevators is !List<ElevatorsResponse> ) {
//    print(elevators.runtimeType);
//  }
  for (int i = 1; i < elevators.length ; i++)  {
//    print(elevators[i].id);
//    print(elevators.length);
    String id = elevators[i].id.toString();
    String status = elevators[i].elevatorStatus.toString();
    buttonsList
        .add(new RaisedButton(onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                      children: <Widget>[
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
                        Text(
                            'Elevator\'s ID : ${elevators[i].id} \n '
                                'Elevator\'s building type : ${elevators[i].buildingType} \n'
                              'Elevator\'s serial number : ${elevators[i].elevatorSerialNumber}\n'
                                'Elevator\'s model : ${elevators[i].elevatorModel}\n'
                                'Elevator\'s status : ${elevators[i].elevatorStatus}\n'
                                'Elevator\'s information : ${elevators[i].elevatorInformation}'
                        ),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.bottomCenter,
                          child: RaisedButton.icon(
                            color: elevators[i].elevatorStatus == 'active' ? Colors.green : Colors.red,
                            onPressed: ()  {
                              ElevatorsResponse elevator = new ElevatorsResponse(
                                id: elevators[i].id,
                              buildingType: elevators[i].buildingType,
                              elevatorModel: elevators[i].elevatorModel,
                              elevatorStatus: elevators[i].elevatorStatus,
                              elevatorInformation: elevators[i].elevatorInformation,
                              elevatorSerialNumber: elevators[i].elevatorSerialNumber,
                              columnId: elevators[i].columnId)
                              ;
                                  elevator.elevatorStatus = 'active';
                                  print(elevator.elevatorStatus);
                                  ElevatorsRepository repo = new ElevatorsRepository();
                                  repo.putElevators(elevator);
//                              ElevatorsResponse newElevators = await getElevators();
//                              elevatorList(context, newElevators);
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new Elevators()));
//                                  .then((value) {
//                              setState(() {
//                              color = color == Colors.white ? Colors.grey : Colors.white;
                            },
                            label: Text(
                              elevators[i].elevatorStatus == 'active' ?
                              'elevator\'s status \n'
                                  'is already active' :
                                'Change elevator\'s \n'
                                    ' status to '
                                    'active'

                            ),
                            icon: Icon(
                              Icons.send,
                            ),
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.all(50.0),
                          alignment: Alignment.bottomCenter,
                            height: 350,
                            child: new Image.asset(
                              "assets/elevator.png",
//                              width: 150,
//                              height: 300,
                            ),
                        ),
                      ]
                ),
              );
            }
          );
    },
        color: Colors.blue,
        child: Text(
            'Elevators : $id status: $status'
                )
    )
    );}
  return buttonsList;
}