part of 'data_status_bloc.dart';

enum VehicleDataStatus {
  loadingData,
  loadedData,
  loadingFav,
  loadedFav,
  changeSomeData,
}

class VehicleDataState {
  final List<Vehicle> vehicleData;
  final List<Vehicle> favData;
  final VehicleType type;
  final VehicleDataStatus status;

  const VehicleDataState({
    required this.vehicleData,
    required this.favData,
    required this.status,
    required this.type,
  });

  factory VehicleDataState.initial() {
    return const VehicleDataState(
        vehicleData: [],
        favData: [],
        status: VehicleDataStatus.loadingData,
        type: VehicleType.car);
  }

  VehicleDataState copyWith(
      {List<Vehicle>? vehicleData,
      List<Vehicle>? favData,
      VehicleDataStatus? status,
      VehicleType? type}) {
    return VehicleDataState(
        vehicleData: vehicleData ?? this.vehicleData,
        favData: favData ?? this.favData,
        status: status ?? this.status,
        type: type ?? this.type);
  }

  VehicleDataState editEntry({required Vehicle vehicle, required int index}) {
    if (index != -1) {
      vehicleData[index] = vehicle;
    } else {
      if (favData.indexWhere((element) => element.id == vehicle.id) == -1) {
        favData.add(vehicle);
      } else {
        favData.removeWhere((element) => element.id == vehicle.id);
      }
      int index = vehicleData.indexWhere((element) => element.id == vehicle.id);
      vehicleData[index] = vehicle;
    }

    return VehicleDataState(
        vehicleData: vehicleData,
        favData: favData,
        status: VehicleDataStatus.changeSomeData,
        type: type);
  }
}
