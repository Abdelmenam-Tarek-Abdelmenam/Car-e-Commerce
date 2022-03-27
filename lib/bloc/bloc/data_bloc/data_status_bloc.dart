import 'package:bloc/bloc.dart';
import 'package:car_e_commerce/shared/widgets/toast_helper.dart';
import '../../../data/local/sql_database.dart';
import '../../../data/module/products/vehicle.dart';
import '../../../data/web/firestore_repository.dart';

part 'data_status_event.dart';
part 'data_status_state.dart';

class DataStatusBloc extends Bloc<VehicleDataEvent, VehicleDataState> {
  DataStatusBloc() : super(VehicleDataLoading()) {
    on<LoadAllVehicleData>(_getAllData);
    on<LoadBrandVehicleData>(_getAllBrandData);
  }

  final DataBaseRepository _dataBaseRepository = DataBaseRepository();
  final FireStoreRepository _fireStoreRepository = FireStoreRepository();

  void _getAllData(
      LoadAllVehicleData event, Emitter<VehicleDataState> emit) async {
    showToast("getting all data");
    emit(VehicleDataLoading());
    VehicleType vehicleType = event.type;
    List<Vehicle> needData;
    if (DataBaseRepository.database == null) {
      needData = await _fireStoreRepository.getAllVehicleData(
          vehicleType: vehicleType);
    } else {
      needData =
          await _dataBaseRepository.getAllVehicleData(vehicleType: vehicleType);
    }
    emit(VehicleDataLoaded(vehicleData: needData));
  }

  Future<void> _getAllBrandData(
      LoadBrandVehicleData event, Emitter<VehicleDataState> emit) async {
    emit(VehicleDataLoading());
    String brand = event.brandName;
    VehicleType vehicleType = event.type;
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
    emit(VehicleDataLoaded(vehicleData: needData));
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
