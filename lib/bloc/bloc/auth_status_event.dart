part of 'auth_status_bloc.dart';

@immutable
abstract class AuthStatusEvent {
  AuthStatusEvent();
}

class AuthLogoutEvent extends AuthStatusEvent {}

class UserChangedState extends AuthStatusEvent {
  final AppUser userApp;
  UserChangedState(this.userApp);

  @override
  List<Object?> get props => [userApp];

}
