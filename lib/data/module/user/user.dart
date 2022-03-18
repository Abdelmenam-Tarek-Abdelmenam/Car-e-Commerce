import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String? email;
  final String? photoUrl;
  final String? name;

  AppUser({
    required this.id,
    this.email,
    this.photoUrl,
    this.name,
  });

  AppUser.empty() : this(id: '');

  bool get isEmpty {
    return AppUser == null ;
  }
  @override
  List<Object?> get props => [id];
}
