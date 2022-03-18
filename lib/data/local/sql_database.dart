import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';

import '../module/products/car.dart';
import '../module/products/motor_cycle.dart';
import '../module/products/vehicle.dart';

class DataBaseRepository {
  static int lastVersion = 1;
  static Database? database;

  static Future<void> initializeDataBase() async {
    bool dataBaseExists = await databaseExists("data.db");
    if (dataBaseExists) {
      database = await openDatabase("data.db");
    }

    int? databaseVersion = (await database?.getVersion());
    FirebaseDatabase.instance.ref().child("version").get().then((versionRef) {
      lastVersion = versionRef.value as int;
      if (lastVersion != databaseVersion) {
        deleteDatabase("data.db");
        database = null;
      }
    });
  }

  Future<List<Vehicle>> getAllVehicleData(
      {VehicleType vehicleType = VehicleType.car}) async {
    String tableName = {
      VehicleType.car: "cars",
      VehicleType.motorCycle: "motorCycle",
      VehicleType.bike: "bikes"
    }[vehicleType]!;
    List<Map<String, dynamic>> allVehiclesData =
        await database?.query(tableName) ?? [];

    return _mapsToVehicle(allVehiclesData, vehicleType);
  }

  Future<List<Vehicle>> getAllBrandData(String brandName,
      {VehicleType vehicleType = VehicleType.car}) async {
    String tableName = {
      VehicleType.car: "cars",
      VehicleType.motorCycle: "motorCycle",
      VehicleType.bike: "bikes"
    }[vehicleType]!;
    List<Map<String, dynamic>> allVehiclesData =
        await database?.query(tableName, where: "brand = $brandName") ?? [];

    return _mapsToVehicle(allVehiclesData, vehicleType);
  }

  List<Vehicle> _mapsToVehicle(
      List<Map<String, dynamic>> allVehiclesData, VehicleType vehicleType) {
    switch (vehicleType) {
      case VehicleType.car:
        return allVehiclesData.map((e) => Car.fromJson(e)).toList();
      case VehicleType.motorCycle:
        return allVehiclesData.map((e) => MotorCycle.fromJson(e)).toList();
      case VehicleType.bike:
        return [];
    }
  }
}
