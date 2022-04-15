part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<Vehicle> filteredVehicles;

  const FilterLoaded({
    this.filteredVehicles = const [], // default value
  });

  @override
  List<Object> get props => [filteredVehicles];
}
