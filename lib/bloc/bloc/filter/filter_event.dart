part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

// press on the show detail btn
class LoadFilter extends FilterEvent {
  @override
  List<Object> get props => [];
}

class FilterUpdatedFilter extends FilterEvent {
  final CarTransmission? transmissionType;
  final String? countryName;
  final List<int>? priceRange;

  const FilterUpdatedFilter(
      {this.countryName, this.priceRange, this.transmissionType});
}
