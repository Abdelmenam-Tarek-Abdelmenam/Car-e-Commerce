import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';

import '../local/sql_database.dart';

class FireStoreRepository {
  final FirebaseFirestore _firebaseFirestoretore = FirebaseFirestore.instance;

  Future<List<Vehicle>> getAllVehicleData(
      {required VehicleType vehicleType}) async {
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
      {required VehicleType vehicleType}) async {
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
    return allVehiclesDocuments
        .map((e) => Vehicle.fromQueryDocument(e, vehicleType))
        .toList();
  }

  Future<void> saveDataLocal(
      {required List<Vehicle> subData,
      VehicleType vehicleType = VehicleType.car}) async {
    String tableName = _getCollectionName(vehicleType);
    Database database = await openDatabase(
      "data.db",
      version: DataBaseRepository.lastVersion,
      onCreate: (Database db, int version) async {
        String columnNames = '''(
                      "id"	TEXT NOT NULL UNIQUE,
                      "price"	INTEGER,
                      "name"	TEXT,
                      "brand"	TEXT,
                      "video"	TEXT,
                      "fave"	INTEGER,
                      "imageUrl"	TEXT,
                      "properties"	TEXT
                );''';
        await db.execute('''CREATE TABLE "cars" $columnNames''');
        await db.execute('''CREATE TABLE "motorCycle" $columnNames''');
        await db.execute('''CREATE TABLE "bikes" $columnNames''');
      },
    );
    DataBaseRepository.database = database;
    for (Vehicle vehicle in subData) {
      database.insert(tableName, vehicle.toJson()).onError((err, stack) {
        return 0;
      });
    }
  }
}
