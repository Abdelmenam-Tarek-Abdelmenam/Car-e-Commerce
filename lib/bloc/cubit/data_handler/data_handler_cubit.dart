import 'package:bloc/bloc.dart';

import '../../../data/local/sql_database.dart';
import '../../../data/module/products/vehicle.dart';
import '../../../data/web/firestore_repository.dart';
import 'data_handler_state.dart';

class DataHandlerCubit extends Cubit<DataHandlerState> {
  DataHandlerCubit() : super(DataHandlerInitial());

  final DataBaseRepository _dataBaseRepository = DataBaseRepository();
  final FireStoreRepository _fireStoreRepository = FireStoreRepository();

  Future<List<Vehicle>> getAllData(
      {VehicleType vehicleType = VehicleType.car}) async {
    emit(GetDataLoadingState());
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      needData = await _fireStoreRepository.getAllVehicleData(
          vehicleType: vehicleType);
    } else {
      needData =
          await _dataBaseRepository.getAllVehicleData(vehicleType: vehicleType);
    }
    emit(GetDataDoneState());
    return needData;
  }

  Future<List<Vehicle>> getAllBrandData(String brand,
      {VehicleType vehicleType = VehicleType.car}) async {
    emit(GetDataLoadingState());
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      needData = await _fireStoreRepository.getAllBrandData(brand,
          vehicleType: vehicleType);
    } else {
      needData = await _dataBaseRepository.getAllBrandData(brand,
          vehicleType: vehicleType);
      if (needData.isEmpty) {
        needData = await _fireStoreRepository.getAllBrandData(brand,
            vehicleType: vehicleType);
      }
    }
    emit(GetDataDoneState());
    return needData;
  }

  Future<List<Vehicle>> searchVehiclesByName(String subName,
      {VehicleType vehicleType = VehicleType.car, String? brand}) async {
    emit(GetDataLoadingState());
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      await _fireStoreRepository.getAllVehicleData(vehicleType: vehicleType);
      needData = await _dataBaseRepository.getVehicleByName(subName, brand,
          vehicleType: vehicleType);
    } else {
      needData = await _dataBaseRepository.getVehicleByName(subName, brand,
          vehicleType: vehicleType);
    }
    emit(GetDataDoneState());
    return needData;
  }
}
