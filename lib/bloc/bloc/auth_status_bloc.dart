import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/repository/auth_repository.dart';
import 'package:car_e_commerce/data/module/user/user.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthState> {
  AuthRepository _authRepository;

  AuthStatusBloc(this._authRepository) : super(AuthState.unauthenticated()) {
    on<AuthLogoutEvent>(_authLogOutHandler);
    on<UserChangedState>(_userChangedState);
  }

  void _userChangedState(
    UserChangedState event,
    Emitter<AuthState> emit,
  ) {
    emit(event.userApp.isEmpty
        ? AuthState.authenticated(event.userApp)
        : AuthState.unauthenticated());
  }

  void _authLogOutHandler(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) {
    unawaited(_authRepository.signOut());
  }
}