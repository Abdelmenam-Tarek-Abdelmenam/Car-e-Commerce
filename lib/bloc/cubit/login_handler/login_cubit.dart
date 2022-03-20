import 'package:bloc/bloc.dart';
import 'package:car_e_commerce/data/repository/auth_exception.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final AuthRepository auth;
  LoginCubit(this.auth) : super(LoginStates.initial());

  void emailChange(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.intial));
  }

  void passwordChange(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.intial));
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await auth.signInUsingGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(errorMessage: e.message, status: LoginStatus.error),
      );
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.error),
      );
    }
  }

  Future<void> signInWithFirebaseByEmailAndPassword() async {
    if (state.status == LoginStatus.submitting) {
      return;
    }
    emit(state.copyWith(status: LoginStatus.submitting));

    try {
      await auth.signInWithEmailAndPassword(state.email, state.password);
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
