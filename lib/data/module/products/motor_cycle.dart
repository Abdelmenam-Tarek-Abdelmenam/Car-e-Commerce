import 'dart:convert';

import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MotorCycle extends Vehicle {
  MotorCycle({
    required String name,
    required String id,
    required String brand,
    required String imgUrl,
    required int price,
    required Map<String, dynamic> properties,
  }) : super(
            name: name,
            price: price,
            brand: brand,
            imgUrl: imgUrl,
            id: id,
            properties: properties);

  static MotorCycle fromQueryDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> rowData) {
    return MotorCycle(
        id: rowData.id,
        name: rowData.get('Name'),
        brand: rowData.get("Brand"),
        price: rowData.get("Price"),
        imgUrl: rowData.get("Image"),
        properties: rowData.get("Proberties"));
  }

  static MotorCycle fromJson(Map<String, dynamic> jsonData) {
    return MotorCycle(
        name: jsonData['name'],
        id: jsonData['id'],
        brand: jsonData['brand'],
        price: jsonData["price"],
        imgUrl: jsonData['imageUrl'],
        properties: json.decode(jsonData['properties']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "brand": brand,
      "price": price,
      "imageUrl": imgUrl,
      "properties": json.encode(properties)
    };
  }
}
