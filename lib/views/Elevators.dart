import 'package:flutter/material.dart';
import 'package:rocketelevatorsapp/repository/Elevators_repository.dart';
import 'package:rocketelevatorsapp/models/elevatorResponse.dart';
import 'dart:async';

//for debugging
//void main() => runApp(Elevators());

class Elevators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body : FutureBuilder(
      future: getElevators(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return Scaffold(
              body: Center(child: Text("Error : ${snapshot.error}")));
        if (snapshot.hasData) {
          print('Data found. ${snapshot.hasData}');
          print('Snpashot data : ${snapshot.data.runtimeType}');
//          return CircularProgressIndicator();
          print(snapshot.data);
//          List<ElevatorsResponse> elevators = new List<ElevatorsResponse>(snapshot.data);
          return elevatorList(context, snapshot.data);
        } else {
          print('no data found. $snapshot and ${snapshot.hasData}');
          return loadingScreen(context);
        }
      })
    );
  }
}

Future<List<ElevatorsResponse>> getElevators() async {
  print('triggered');
  dynamic elevator = new ElevatorsRepository();
  List<ElevatorsResponse> elevators = await elevator.fetchElevators();
//  print('elevators Type : ${elevators.runtimeType}, can call ID? ${elevators.first.id}');
  return elevators;
}

Widget elevatorList(BuildContext context, List<ElevatorsResponse> elevators) {
  print('ElevatorList: ${elevators.runtimeType}');
  return Scaffold(
    body:
    new Center(
      child: new Wrap(
        children: [
        new Container(
          child: Text(
        'there are currently ${elevators.length} inactive elevators.\n '
            'Swipe up and press any elevator\'s button. '
      ),
    ),
      new Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            spacing: 10.0,
            children: _buildButtonsWithNames(context, elevators)
        )
    ]),
  ),
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
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new Elevators()));
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
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.bottomCenter,
                            height: 340,
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

Widget loadingScreen(context) {
  return Scaffold(
      body: Center(
                child: CircularProgressIndicator(
                ),
      ),
  );

}