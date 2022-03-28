import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Vehicle extends Equatable {
  String id;
  String name;
  String brand;
  String imgUrl;
  int price;
  bool isFav;
  Map<String, dynamic> properties;
  //  Type typeVehicle;

  Vehicle(
      {required this.name,
      required this.id,
      required this.brand,
      required this.price,
      required this.imgUrl,
      required this.isFav,
      required this.properties});

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [id, isFav];
}

enum VehicleType {
  all,
  car,
  motorCycle,
  bike,
}
