import 'package:flutter/material.dart';

class Elevators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elevators'),
        actions: <Widget>[
          IconButton(
            icon: Text(
              "Logout",

            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            }
          )
        ]
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen when tapped.
          },
        ),
      ),
    );
  }
}