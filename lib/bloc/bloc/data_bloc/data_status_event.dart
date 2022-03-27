part of 'data_status_bloc.dart';

abstract class VehicleDataEvent {
  const VehicleDataEvent();
}

class LoadAllVehicleData extends VehicleDataEvent {
  final VehicleType type;

  const LoadAllVehicleData({this.type = VehicleType.car});
}

class LoadBrandVehicleData extends VehicleDataEvent {
  final String brandName;
  final VehicleType type;

  const LoadBrandVehicleData(
      {required this.brandName, this.type = VehicleType.car});
}
