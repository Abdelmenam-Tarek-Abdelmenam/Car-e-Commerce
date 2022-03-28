import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/local/sql_database.dart';
import '../../../data/module/products/vehicle.dart';
import '../../../data/web/firestore_repository.dart';

part 'data_status_event.dart';
part 'data_status_state.dart';

class DataStatusBloc extends Bloc<VehicleDataEvent, VehicleDataState> {
  DataStatusBloc() : super(VehicleDataState.initial()) {
    on<LoadAllVehicleData>(_getAllData);
    on<LoadAllFavData>(_getFavData);
    on<LoadBrandVehicleData>(_getAllBrandData);
    on<EditVehicleData>(_editVehicleData);
    on<EditVehicleType>(_editVehiclesType);
  }

  final DataBaseRepository _dataBaseRepository = DataBaseRepository();
  final FireStoreRepository _fireStoreRepository = FireStoreRepository();

  void _getAllData(
      LoadAllVehicleData event, Emitter<VehicleDataState> emit) async {
    emit(state.copyWith(status: VehicleDataStatus.loadingData));
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      needData =
          await _fireStoreRepository.getAllVehicleData(vehicleType: event.type);
    } else {
      needData =
          await _dataBaseRepository.getAllVehicleData(vehicleType: event.type);
    }
    emit(state.copyWith(
        status: VehicleDataStatus.loadedData, vehicleData: needData));
  }

  Future<void> _getAllBrandData(
      LoadBrandVehicleData event, Emitter<VehicleDataState> emit) async {
    emit(state.copyWith(status: VehicleDataStatus.loadingData));
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      needData = await _fireStoreRepository.getAllBrandData(event.brandName,
          vehicleType: event.type);
    } else {
      needData = await _dataBaseRepository.getAllBrandData(event.brandName,
          vehicleType: event.type);
      if (needData.isEmpty) {
        needData = await _fireStoreRepository.getAllBrandData(event.brandName,
            vehicleType: event.type);
      }
    }
    emit(state.copyWith(
        status: VehicleDataStatus.loadedData, vehicleData: needData));
  }

  Future<void> _editVehicleData(
      EditVehicleData event, Emitter<VehicleDataState> emit) async {
    await _dataBaseRepository.changeVehicleData(event.vehicle);
    emit(state.editEntry(vehicle: event.vehicle, index: event.indexInList));
  }

  Future<void> _editVehiclesType(
      EditVehicleType event, Emitter<VehicleDataState> emit) async {
    emit(state.copyWith(
        type: event.newType, status: VehicleDataStatus.changeSomeData));
  }

  void _getFavData(LoadAllFavData event, Emitter<VehicleDataState> emit) async {
    emit(state.copyWith(status: VehicleDataStatus.loadingFav, favData: []));
    List<Vehicle> needData;
    needData =
        await _dataBaseRepository.changeAllFavorite(vehicleType: event.type);
    emit(
        state.copyWith(status: VehicleDataStatus.loadedFav, favData: needData));
  }

  Future<List<Vehicle>> searchVehiclesByName(String subName,
      {VehicleType vehicleType = VehicleType.car, String? brand}) async {
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      await _fireStoreRepository.getAllVehicleData(vehicleType: vehicleType);
    }
    needData = await _dataBaseRepository.getVehicleByName(subName, brand,
        vehicleType: vehicleType);
    return needData;
  }
}
