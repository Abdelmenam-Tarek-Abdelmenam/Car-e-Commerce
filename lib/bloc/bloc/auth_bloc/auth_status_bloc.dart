import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:car_e_commerce/data/module/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/repository/auth_repository.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthStatusBloc(this._authRepository)
      : super(AuthState.initial(_authRepository.auth.currentUser)) {
    on<AuthLogoutEvent>(_authLogOutHandler);
    on<UserChangedState>(_userChangedState);
  }

  void _userChangedState(
    UserChangedState event,
    Emitter<AuthState> emit,
  ) {
    emit(event.userApp.isEmpty
        ? AuthState.unauthenticated()
        : AuthState.authenticated(event.userApp));
  }

  void _authLogOutHandler(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) {
    unawaited(_authRepository.signOut());
  }
}
