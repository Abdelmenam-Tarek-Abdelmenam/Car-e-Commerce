import 'dart:convert';

import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Car extends Vehicle {
  String video;

  Car({
    required String name,
    required String id,
    required String brand,
    required String imgUrl,
    required this.video,
    required int price,
    required Map<String, dynamic> properties,
  }) : super(
          name: name,
          price: price,
          brand: brand,
          imgUrl: imgUrl,
          id: id,
          properties: properties,
        );

  static Car fromQueryDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> rowData) {
    return Car(
        id: rowData.id,
        name: rowData.get('Name'),
        brand: rowData.get("Brand"),
        price: rowData.get("Price"),
        imgUrl: rowData.get("Image"),
        video: rowData.get("Video"),
        properties: rowData.get("Proberties"));
  }

  static Car fromJson(Map<String, dynamic> jsonData) {
    return Car(
        name: jsonData['name'],
        id: jsonData['id'],
        brand: jsonData['brand'],
        price: jsonData["price"],
        imgUrl: jsonData['imageUrl'],
        properties: json.decode(jsonData['properties']),
        video: jsonData['video']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "brand": brand,
      "price": price,
      "imageUrl": imgUrl,
      "video": video,
      "properties": json.encode(properties)
    };
  }
}
