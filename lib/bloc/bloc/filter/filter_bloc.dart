import 'package:bloc/bloc.dart';
import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:car_e_commerce/data/web/firestore_repository.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/bottom_sheet.dart';
import 'package:equatable/equatable.dart';
import '../../../data/module/filter/filtered_vehicle.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
    final FireStoreRepository _fireStoreRepository = FireStoreRepository();

  FilterBloc() : super(FilterLoaded());

  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    if (event is UpdatePrice) {
      yield* _mapUpdatePrice(event, state);
    }
  }

  Stream<FilterState> _mapUpdatePrice(
      UpdatePrice event, FilterState state) async* {
    if (state is FilterLoaded) {
      final List<Vehicle> filteredByPrice =
          await _fireStoreRepository.getFilteredVehicles(event.priceRange,"soa", VehicleType.car);
      yield FilterLoaded(
          filter: Filtered(
        price: filteredByPrice,
      ));
    }
  }
}
