part of 'data_status_bloc.dart';

abstract class VehicleDataEvent extends Equatable {
  const VehicleDataEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllVehicleData extends VehicleDataEvent {
  const LoadAllVehicleData();

  @override
  List<Object?> get props => [];
}

class LoadAllFavData extends VehicleDataEvent {
  const LoadAllFavData();

  @override
  List<Object?> get props => [];
}

class LoadBrandVehicleData extends VehicleDataEvent {
  final String brandName;

  const LoadBrandVehicleData({required this.brandName});

  @override
  List<Object?> get props => [brandName];
}

class EditVehicleData extends VehicleDataEvent {
  final Vehicle vehicle;
  final int indexInList;

  const EditVehicleData({required this.vehicle, required this.indexInList});

  @override
  List<Object?> get props => [indexInList, vehicle];
}

class EditVehicleType extends VehicleDataEvent {
  final VehicleType type;
  const EditVehicleType(this.type);

  @override
  List<Object?> get props => [type];
}

class SearchByName extends VehicleDataEvent {
  final String subName;
  const SearchByName(this.subName);

  @override
  List<Object?> get props => [subName];
}
