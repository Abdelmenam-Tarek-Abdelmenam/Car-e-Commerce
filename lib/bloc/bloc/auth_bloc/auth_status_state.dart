part of 'auth_status_bloc.dart';

enum AuthStatus {
  authed,
  unauthed,
}

// ignore: must_be_immutable
class AuthState extends Equatable {
  late AuthStatus status;
  AppUser user = AppUser.empty;

  AuthState({
    required this.status,
    this.user = AppUser.empty,
  });

  // when the user state is  signed in (authenticated)
  AuthState.authenticated(AppUser user)
      : this(
          status: AuthStatus.authed,
          user: user,
        );

  AuthState.initial(
    User? user,
  ) {
    if (user == null) {
      status = AuthStatus.unauthed;
      user = null;
    } else {
      status = AuthStatus.authed;
      this.user = AppUser(
          id: user.uid,
          name: user.displayName,
          email: user.email,
          photoUrl: user.photoURL);
    }
  }

  // when the user state isn't signed in (unauthenticated)
  AuthState.unauthenticated()
      : this(
          status: AuthStatus.unauthed,
          user: AppUser.empty,
        );

  // comparing the state
  @override
  List<Object?> get props => [status, user];
}
