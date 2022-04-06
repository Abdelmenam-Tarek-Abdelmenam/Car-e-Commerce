import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/local/sql_database.dart';
import '../../../data/module/products/vehicle.dart';
import '../../../data/web/firestore_repository.dart';

part 'data_status_event.dart';
part 'data_status_state.dart';

class DataStatusBloc extends Bloc<VehicleDataEvent, VehicleDataState> {
  DataStatusBloc(VehicleType type) : super(VehicleDataState.initial(type)) {
    on<LoadAllVehicleData>(_getAllData);
    on<LoadAllFavData>(_getFavData);
    on<LoadBrandVehicleData>(_getAllBrandData);
    on<EditVehicleData>(_editVehicleData);
    on<EditVehicleType>(_editVehiclesType);
    on<SearchByName>(_searchVehiclesByName);
  }

  final DataBaseRepository _dataBaseRepository = DataBaseRepository();
  final FireStoreRepository _fireStoreRepository = FireStoreRepository();

  Future<void> _getAllData(
      LoadAllVehicleData event, Emitter<VehicleDataState> emit) async {
    emit(state.copyWith(status: VehicleDataStatus.loadingData));
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      needData =
          await _fireStoreRepository.getAllVehicleData(vehicleType: state.type);
    } else {
      needData =
          await _dataBaseRepository.getAllVehicleData(vehicleType: state.type);
      if (needData.isEmpty) {
        needData = await _fireStoreRepository.getAllVehicleData(
            vehicleType: state.type);
      }
    }
    emit(state.copyWith(
        status: VehicleDataStatus.loadedData,
        vehicleData: needData,
        brand: "All"));
  }

  Future<void> _getAllBrandData(
      LoadBrandVehicleData event, Emitter<VehicleDataState> emit) async {
    if (state.brand == event.brandName) return;
    emit(state.copyWith(status: VehicleDataStatus.loadingData));
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      needData = await _fireStoreRepository.getAllBrandData(event.brandName,
          vehicleType: state.type);
    } else {
      needData = await _dataBaseRepository.getAllBrandData(event.brandName,
          vehicleType: state.type);
      if (needData.isEmpty) {
        needData = await _fireStoreRepository.getAllBrandData(event.brandName,
            vehicleType: state.type);
      }
    }
    emit(state.copyWith(
        status: VehicleDataStatus.loadedData,
        vehicleData: needData,
        brand: event.brandName));
  }

  Future<void> _editVehicleData(
      EditVehicleData event, Emitter<VehicleDataState> emit) async {
    await _dataBaseRepository.changeVehicleData(event.vehicle,
        vehicleType: state.type);
    emit(state.editEntry(vehicle: event.vehicle, index: event.indexInList));
  }

  Future<void> _editVehiclesType(
      EditVehicleType event, Emitter<VehicleDataState> emit) async {
    emit(state.copyWith(
        type: event.type, status: VehicleDataStatus.changeSomeData));
    await _getAllData(const LoadAllVehicleData(), emit);
    await _getFavData(const LoadAllFavData(), emit);
  }

  Future<void> _getFavData(
      LoadAllFavData event, Emitter<VehicleDataState> emit) async {
    emit(state.copyWith(status: VehicleDataStatus.loadingFav, favData: []));
    List<Vehicle> needData;
    needData =
        await _dataBaseRepository.changeAllFavorite(vehicleType: state.type);
    emit(
        state.copyWith(status: VehicleDataStatus.loadedFav, favData: needData));
  }

  Future<void> _searchVehiclesByName(
      SearchByName event, Emitter<VehicleDataState> emit) async {
    emit(
        state.copyWith(status: VehicleDataStatus.loadingData, vehicleData: []));
    List<Vehicle> needData;

    if (DataBaseRepository.database == null) {
      await _fireStoreRepository.getAllVehicleData(vehicleType: state.type);
    }
    needData = await _dataBaseRepository.getVehicleByName(
        event.subName, state.brand == "All" ? null : state.brand,
        vehicleType: state.type);
    emit(state.copyWith(
        status: VehicleDataStatus.loadedData, vehicleData: needData));
  }

  Future<List<Vehicle>> searchVehiclesByName(String subName) async {
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      await _fireStoreRepository.getAllVehicleData(vehicleType: state.type);
    }
    needData = await _dataBaseRepository.getVehicleByName(subName, null,
        vehicleType: state.type);

    return needData;
  }
}
