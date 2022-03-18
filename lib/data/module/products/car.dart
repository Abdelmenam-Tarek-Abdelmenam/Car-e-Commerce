import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Car extends Vehicle {
  // late String id;
  // late String name;
  // late String brand;
  // late String imgUrl;
  // // late Type typeVehicle;
  // late double price;
  Car({
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
        properties: rowData.get("Proberties"));
  }
}
