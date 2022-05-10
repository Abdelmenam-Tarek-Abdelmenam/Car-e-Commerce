import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:car_e_commerce/constants/enums.dart';
import 'package:car_e_commerce/data/local/sql_database.dart';
import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:equatable/equatable.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final DataBaseRepository _dataBaseRepository = DataBaseRepository();

  FilterBloc() : super(const FilterLoaded()) {
    on<FilterUpdatedFilter>(_getFilterData);
  }

  Future<void> _getFilterData(
      FilterUpdatedFilter event, Emitter<FilterState> emit) async {
    List<Vehicle>? needData = await _dataBaseRepository.getVehicleFiltered(
      vehicleType: VehicleType.car,
      carTransmission: event.transmissionType,
      countryName: event.countryName,
      priceRange: event.priceRange,
    );
    emit(FilterLoaded(filteredVehicles: needData!));
  }
}
