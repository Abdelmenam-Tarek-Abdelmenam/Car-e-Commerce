import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Vehicle extends Equatable {
  late String id;
  late String name;
  late String brand;
  late String imgUrl;
  late int price;
  late bool isFav;
  late Map<String, dynamic> properties;
  late VehicleType typeVehicle;
  late String video;

  Vehicle(
      {required this.name,
      required this.id,
      required this.brand,
      required this.price,
      required this.imgUrl,
      required this.isFav,
      required this.properties,
      required this.typeVehicle,
      required this.video});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "brand": brand,
      "price": price,
      "fave": isFav ? 1 : 0,
      "video": video,
      "imageUrl": imgUrl,
      "properties": json.encode(properties)
    };
  }

  Vehicle.fromJson(Map<String, dynamic> jsonData, VehicleType type) {
    name = jsonData['name'];
    id = jsonData['id'];
    brand = jsonData['brand'];
    price = jsonData["price"];
    isFav = jsonData['fave'] == 1;
    imgUrl = jsonData['imageUrl'];
    properties = json.decode(jsonData['properties']);
    typeVehicle = type;
    video = jsonData['video'] ?? "noVideo";
  }

  Vehicle.fromQueryDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> rowData, VehicleType type) {
    id = rowData.id;
    name = rowData.get('Name');
    brand = rowData.get("Brand");
    price = rowData.get("Price");
    imgUrl = rowData.get("Image");
    isFav = false;
    properties = rowData.get("Proberties");
    typeVehicle = type;
    if (typeVehicle == VehicleType.car) {
      video = rowData.get("Video");
    } else {
      video = "noVideo";
    }
  }

  @override
  List<Object?> get props => [id, isFav];
}

enum VehicleType {
  all,
  car,
  motorCycle,
  bike,
}
