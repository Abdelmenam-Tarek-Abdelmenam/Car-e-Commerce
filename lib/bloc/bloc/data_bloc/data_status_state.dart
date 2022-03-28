part of 'data_status_bloc.dart';

enum VehicleDataStatus {
  loadingData,
  loadedData,
  changeSomeData,
}

class VehicleDataState {
  final List<Vehicle> vehicleData;
  final VehicleType type;
  final VehicleDataStatus status;

  const VehicleDataState({
    required this.vehicleData,
    required this.status,
    required this.type,
  });

  factory VehicleDataState.initial() {
    return const VehicleDataState(
        vehicleData: [],
        status: VehicleDataStatus.loadingData,
        type: VehicleType.car);
  }

  VehicleDataState copyWith(
      {List<Vehicle>? vehicleData,
      VehicleDataStatus? status,
      VehicleType? type}) {
    return VehicleDataState(
        vehicleData: vehicleData ?? this.vehicleData,
        status: status ?? this.status,
        type: type ?? this.type);
  }

  VehicleDataState editEntry({required Vehicle vehicle, required int index}) {
    vehicleData[index] = vehicle;

    return VehicleDataState(
        vehicleData: vehicleData,
        status: VehicleDataStatus.changeSomeData,
        type: type);
  }
}
