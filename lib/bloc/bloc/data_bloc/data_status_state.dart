part of 'data_status_bloc.dart';

abstract class VehicleDataState {
  const VehicleDataState();
}

class VehicleDataLoading extends VehicleDataState {}

class VehicleDataLoaded extends VehicleDataState {
  final List<Vehicle> vehicleData;
  const VehicleDataLoaded({this.vehicleData = const []});
}
