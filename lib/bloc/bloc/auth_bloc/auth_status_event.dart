part of "auth_status_bloc.dart";

abstract class AuthStatusEvent {
  const AuthStatusEvent();
}

class AuthLogoutEvent extends AuthStatusEvent {}

class UserChangedState extends AuthStatusEvent {
  final AppUser userApp;
  const UserChangedState(this.userApp);

  List<Object?> get props => [userApp];
}
