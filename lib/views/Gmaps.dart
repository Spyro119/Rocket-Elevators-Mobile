import 'package:flutter/material.dart';
import 'package:rocketelevatorsapp/repository/Gmaps_repository.dart';
import 'package:rocketelevatorsapp/models/Gmaps.dart';
import 'dart:async';

GmapsRepository location = new GmapsRepository();

Future<Location> getLocation(id) async{
  print('triggered too! $id');
  Location elevatorsLocation = await location.getLocation(id);
  print("Address be at : $elevatorsLocation");
  return elevatorsLocation;
}