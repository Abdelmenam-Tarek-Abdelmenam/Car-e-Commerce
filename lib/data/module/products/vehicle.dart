enum Type {
  car,
  motorCycle,
  bike,
}

abstract class Vehicle {
  late String id;
  late String name;
  late String imgUrl;
  late Type typeVehicle;
  late double price;
}
