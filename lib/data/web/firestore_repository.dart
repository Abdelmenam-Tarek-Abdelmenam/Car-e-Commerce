import 'package:car_e_commerce/data/module/products/car.dart';
import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';

import '../local/sql_database.dart';
import '../module/products/motor_cycle.dart';

class FireStoreRepository {
  final FirebaseFirestore _firebaseFirestoretore = FirebaseFirestore.instance;

  Future<List<Vehicle>> getAllVehicleData(
      {VehicleType vehicleType = VehicleType.car}) async {
    String collectionName = _getCollectionName(vehicleType);

    QuerySnapshot<Map<String, dynamic>> vehiclesSnapShot;
    try {
      vehiclesSnapShot =
          await _firebaseFirestoretore.collection(collectionName).get();
    } catch (err) {
      return [];
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allVehiclesDocuments =
        vehiclesSnapShot.docs;
    List<Vehicle> allVehicles =
        _docsToVehicle(allVehiclesDocuments, vehicleType);
    saveDataLocal(subData: allVehicles, vehicleType: vehicleType);
    return allVehicles;
  }

  Future<List<Vehicle>> getAllBrandData(String brandName,
      {VehicleType vehicleType = VehicleType.car}) async {
    String collectionName = _getCollectionName(vehicleType);
    QuerySnapshot<Map<String, dynamic>> vehiclesSnapShot;
    try {
      vehiclesSnapShot = await _firebaseFirestoretore
          .collection(collectionName)
          .where("Brand", isEqualTo: brandName)
          .get();
    } catch (err) {
      return [];
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allVehiclesDocuments =
        vehiclesSnapShot.docs;
    List<Vehicle> allVehicles =
        _docsToVehicle(allVehiclesDocuments, vehicleType);
    saveDataLocal(subData: allVehicles, vehicleType: vehicleType);
    return allVehicles;
  }

  String _getCollectionName(VehicleType vehicleType) {
    return {
      VehicleType.car: "cars",
      VehicleType.motorCycle: "motorCycle",
      VehicleType.bike: "bikes"
    }[vehicleType]!;
  }

  List<Vehicle> _docsToVehicle(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> allVehiclesDocuments,
      VehicleType vehicleType) {
    switch (vehicleType) {
      case VehicleType.car:
        return allVehiclesDocuments
            .map((e) => Car.fromQueryDocument(e))
            .toList();
      case VehicleType.motorCycle:
        return allVehiclesDocuments
            .map((e) => MotorCycle.fromQueryDocument(e))
            .toList();
      case VehicleType.bike:
        return [];
    }
  }

  Future<void> saveDataLocal(
      {required List<Vehicle> subData,
      VehicleType vehicleType = VehicleType.car}) async {
    String tableName = _getCollectionName(vehicleType);
    Database database = await openDatabase(
      "data.db",
      version: DataBaseRepository.lastVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE "$tableName" (
                      "id"	TEXT NOT NULL UNIQUE,
                      "price"	INTEGER,
                      "name"	TEXT,
                      "brand"	TEXT,
                      "video"	TEXT,
                      "imageUrl"	TEXT,
                      "properties"	TEXT
                );''');
      },
    );
    DataBaseRepository.database = database;
    for (Vehicle vehicle in subData) {
      database.insert(tableName, vehicle.toJson()).onError((err, stack) {
        print("item exist before");
        return 0;
      });
    }
  }
}
