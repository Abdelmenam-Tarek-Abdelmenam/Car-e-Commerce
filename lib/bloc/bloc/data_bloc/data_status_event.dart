part of 'data_status_bloc.dart';

abstract class VehicleDataEvent extends Equatable {
  const VehicleDataEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllVehicleData extends VehicleDataEvent {
  final VehicleType type;

  const LoadAllVehicleData({this.type = VehicleType.car});

  @override
  List<Object?> get props => [type];
}

class LoadAllFavData extends VehicleDataEvent {
  final VehicleType type;

  const LoadAllFavData({this.type = VehicleType.car});

  @override
  List<Object?> get props => [type];
}

class LoadBrandVehicleData extends VehicleDataEvent {
  final String brandName;
  final VehicleType type;

  const LoadBrandVehicleData(
      {required this.brandName, this.type = VehicleType.car});

  @override
  List<Object?> get props => [type, brandName];
}

class EditVehicleData extends VehicleDataEvent {
  final Vehicle vehicle;
  final int indexInList;

  const EditVehicleData({required this.vehicle, required this.indexInList});

  @override
  List<Object?> get props => [indexInList, vehicle];
}

class EditVehicleType extends VehicleDataEvent {
  final VehicleType newType;

  const EditVehicleType({required this.newType});

  @override
  List<Object?> get props => [newType];
}
