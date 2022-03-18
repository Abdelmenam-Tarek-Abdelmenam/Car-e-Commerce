import 'package:equatable/equatable.dart';

// standerized user
class AppUser extends Equatable {
  final String id;
  final String? email;
  final String? photoUrl;
  final String? name;

  const AppUser({
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
  });

  static const empty = AppUser(id: '');

  bool get isEmpty => this == AppUser.empty;

  @override
  List<Object?> get props => [id];
}
