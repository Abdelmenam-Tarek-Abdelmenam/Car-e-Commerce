part of 'login_cubit.dart';

enum LoginStatus { initial, submittingEmail, submittingGoogle, success, error }

class LoginStates extends Equatable {
  final String email;
  final int interestIndex;
  final String password;
  final LoginStatus status;
  final String? errorMessage;

  const LoginStates({
    required this.email,
    required this.password,
    required this.status,
    required this.interestIndex,
    this.errorMessage,
  });

  factory LoginStates.initial() {
    return const LoginStates(
      email: '',
      password: '',
      interestIndex: 0,
      status: LoginStatus.initial,
    );
  }

  @override
  List<Object?> get props => [email, password, status];

  LoginStates copyWith({
    String? email,
    String? password,
    int? index,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      interestIndex: index ?? interestIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
