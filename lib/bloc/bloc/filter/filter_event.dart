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

class UpdatePrice extends FilterEvent {
  final List<int> priceRange;

  UpdatePrice({required this.priceRange});

  @override
  List<Object> get props => [priceRange];
}
