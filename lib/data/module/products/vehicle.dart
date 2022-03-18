abstract class Vehicle {
  String id;
  String name;
  String brand;
  String imgUrl;
  int price;
  Map<String, dynamic> properties;
  //  Type typeVehicle;

  Vehicle(
      {required this.name,
      required this.id,
      required this.brand,
      required this.price,
      required this.imgUrl,
      required this.properties});

  Map<String, dynamic> toJson();
}

enum VehicleType {
  car,
  motorCycle,
  bike,
}
