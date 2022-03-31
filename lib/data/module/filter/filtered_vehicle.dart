import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:equatable/equatable.dart';

class Filtered extends Equatable {
  final List<Vehicle> price;
  final List<Vehicle> manufactureCountry;
  final List<Vehicle> transmissionType;
  final List<Vehicle> engineCapacity;

   const Filtered({
    this.price = const [],
    this.manufactureCountry = const [],
    this.transmissionType = const [],
    this.engineCapacity = const [],
  });

  Filtered copywith(
      {List<Vehicle>? price,
      List<Vehicle>? manufactureCountry,
      List<Vehicle>? transmissionType,
      List<Vehicle>? engineCapacity}) {
    return Filtered(
      price: price ?? this.price,
      manufactureCountry: manufactureCountry ?? this.manufactureCountry,
      transmissionType: transmissionType ?? this.transmissionType,
      engineCapacity: engineCapacity ?? this.engineCapacity,
    );
  }

  @override
  List<Object?> get props =>
      [price, manufactureCountry, transmissionType, engineCapacity];
}
