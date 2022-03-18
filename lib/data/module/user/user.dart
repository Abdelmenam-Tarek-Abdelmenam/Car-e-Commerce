import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String? email;
  final String? photoUrl;
  final String? name;

  const AppUser({
    required this.id,
    this.email,
    this.photoUrl,
    this.name,
  });

  const AppUser.empty() : this(id: '');

  bool get isEmpty {
    return id == '';
  }

  @override
  List<Object?> get props => [id];
}
