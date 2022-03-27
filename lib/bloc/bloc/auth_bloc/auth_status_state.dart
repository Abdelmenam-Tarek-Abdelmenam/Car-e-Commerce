part of 'auth_status_bloc.dart';

enum AuthStatus {
  authed,
  unauthed,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AppUser? user;

  const AuthState({
    required this.status,
    this.user,
  });

  // when the user state is  signed in (authenticated)
  const AuthState.authenticated(AppUser user)
      : this(
          status: AuthStatus.authed,
          user: user,
        );

  // when the user state isn't signed in (unauthenticated)
  const AuthState.unauthenticated()
      : this(
          status: AuthStatus.unauthed,
          user: null,
        );

  // comparing the state
  @override
  List<Object?> get props => [status, user];
}
