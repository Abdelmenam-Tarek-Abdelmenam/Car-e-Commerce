part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final Filtered filter; 

  FilterLoaded({
    this.filter = const Filtered(),
  });
  
@override
  List<Object> get props => [filter];
} 
