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
}
