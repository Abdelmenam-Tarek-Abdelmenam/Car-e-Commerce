import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/enums.dart';
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
    String tableName = _getTableName(vehicleType);
    try {
      List<Map<String, dynamic>> allVehiclesData =
          await database?.query(tableName) ?? [];
      return _mapsToVehicle(allVehiclesData, vehicleType);
    } catch (err) {
      return [];
    }
  }

  Future<List<Vehicle>> getAllBrandData(String brandName,
      {required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    List<Map<String, dynamic>> allVehiclesData =
        await database?.query(tableName, where: "brand = '$brandName'") ?? [];
    return _mapsToVehicle(allVehiclesData, vehicleType);
  }

  Future<List<Vehicle>> getVehicleByName(String subName, String? brandName,
      {required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    List<Map<String, dynamic>> allVehiclesData = await database?.query(
            tableName,
            where:
                "name like '%$subName%' ${brandName == null ? "" : "AND brand = '$brandName'"}") ??
        [];
    return _mapsToVehicle(allVehiclesData, vehicleType);
  }

  Future<List<Vehicle>> changeAllFavorite(
      {required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    List<Map<String, dynamic>> allVehiclesData =
        await database?.query(tableName, where: "fave = 1") ?? [];

    return _mapsToVehicle(allVehiclesData, vehicleType);
  }

  Future<void> changeVehicleData(Vehicle vehicle,
      {required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    await database?.update(tableName, vehicle.toJson(),
        where: "id = '${vehicle.id}'");
  }

  Future<List<Vehicle>> getVehicleByPrice(
      {required List<int> priceRange, required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    List<Map<String, dynamic>> allVehiclesData = await database?.rawQuery(
            'SELECT * FROM $tableName WHERE price BETWEEN ${priceRange[0]} AND ${priceRange[1]}') ??
        [];
    return _mapsToVehicle(allVehiclesData, vehicleType);
  }

  Future<List<Vehicle>> getVehicleByTransmission(
      {required CarTransmission carTransmission,
      required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    switch (carTransmission) {
      case CarTransmission.all:
        List<Map<String, dynamic>> allVehiclesData =
            await database?.rawQuery('SELECT properties FROM $tableName') ?? [];
        return _mapsToVehicle(allVehiclesData, vehicleType);

      case CarTransmission.automatic:
        List<Map<String, dynamic>> allVehiclesData = await database?.rawQuery(
                'SELECT properties FROM $tableName WHERE properties LIKE "%${CarTransmission.automatic.name}%"') ??
            [];
        return _mapsToVehicle(allVehiclesData, vehicleType);

      case CarTransmission.manual:
        List<Map<String, dynamic>> allVehiclesData = await database?.rawQuery(
                'SELECT properties FROM $tableName WHERE properties LIKE "%${CarTransmission.manual.name}%"') ??
            [];
        return _mapsToVehicle(allVehiclesData, vehicleType);

      default:
        List<Map<String, dynamic>> allVehiclesData =
            await database?.rawQuery('SELECT properties FROM $tableName') ?? [];
        return _mapsToVehicle(allVehiclesData, vehicleType);
    }
  }

  Future<List<Vehicle>> getVehicleByProperities(
      {required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    List<Map<String, dynamic>> allVehiclesData =
        await database?.rawQuery('SELECT properties FROM $tableName') ?? [];
    return _mapsToVehicle(allVehiclesData, vehicleType);
  }

  Future<List<Vehicle>> getVehicleByCountries(
      {required String countryName, required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    if (countryName == "All") {
      List<Map<String, dynamic>> allVehiclesData =
          await database?.rawQuery('SELECT * FROM $tableName ') ?? [];
      return _mapsToVehicle(allVehiclesData, vehicleType);
    } else {
      List<Map<String, dynamic>> allVehiclesData = await database?.rawQuery(
              'SELECT * FROM $tableName WHERE properties LIKE "%Assembly Country___$countryName%" ') ??
          [];
      return _mapsToVehicle(allVehiclesData, vehicleType);
    }
  }

  Future<List<Vehicle>?> getVehicleFiltered(
      {List<int>? priceRange,
      CarTransmission? carTransmission,
      String? countryName,
      required VehicleType vehicleType}) async {
    String tableName = _getTableName(vehicleType);
    List<Map<String, dynamic>> allVehiclesData = await database?.rawQuery(
            'SELECT * FROM $tableName WHERE properties LIKE "%Origin Country___${countryName == null || countryName == 'all' ? '%' : countryName}%" AND properties LIKE "%${carTransmission?.name ?? '%'}%" ${priceRange == null ? '' : 'AND price BETWEEN ${priceRange[0]} AND ${priceRange[1]}'}') ??
        [];
    return _mapsToVehicle(allVehiclesData, vehicleType);
  }
}

String _getTableName(VehicleType vehicleType) {
  return {
    VehicleType.car: "cars",
    VehicleType.motorCycle: "motorCycle",
    VehicleType.bike: "bikes"
  }[vehicleType]!;
}

List<Vehicle> _mapsToVehicle(
    List<Map<String, dynamic>> allVehiclesData, VehicleType vehicleType) {
  return allVehiclesData.map((e) => Vehicle.fromJson(e, vehicleType)).toList();
}
