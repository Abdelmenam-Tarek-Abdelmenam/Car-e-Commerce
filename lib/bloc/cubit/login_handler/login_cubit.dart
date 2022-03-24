import 'package:bloc/bloc.dart';
import 'package:car_e_commerce/data/repository/auth_exception.dart';
import 'package:car_e_commerce/shared/widgets/toast_helper.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final AuthRepository auth;
  LoginCubit(this.auth) : super(LoginStates.initial());

  void emailChange(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChange(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void changeShowPasswordState() {
    emit(state.copyWith());
  }

  Future<void> signInWithGoogle() async {
    if ([LoginStatus.submittingEmail, LoginStatus.submittingGoogle]
        .contains(state.status)) {
      return;
    }
    emit(state.copyWith(status: LoginStatus.submittingGoogle));
    try {
      await auth.signInUsingGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      showToast(e.message, ToastType.error);
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
    if ([LoginStatus.submittingEmail, LoginStatus.submittingGoogle]
        .contains(state.status)) {
      return;
    }
    emit(state.copyWith(status: LoginStatus.submittingEmail));

    try {
      await auth.signInWithEmailAndPassword(state.email, state.password);
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      showToast(e.message, ToastType.error);
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
