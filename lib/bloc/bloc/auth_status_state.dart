part of 'auth_status_bloc.dart';


enum AuthStatus {
  authed,
  unauthed,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AppUser? user;

  AuthState({
    required this.status,
    this.user = null,
  });

  // when the user state is  signed in (authenticated)

  AuthState.authenticated(AppUser user)
      : this(
          status: AuthStatus.authed,
          user: user,
        );

  // when the user state isn't signed in (unauthenticated)

  AuthState.unauthenticated()
      : this(
          status: AuthStatus.authed,
          user: null,
        );
  // comparing the state
  @override
  List<Object?> get props => [status, user];
}
