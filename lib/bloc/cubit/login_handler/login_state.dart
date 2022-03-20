part of 'login_cubit.dart';

enum LoginStatus { intial, submitting, success, error }

class LoginStates extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorMessage;

  const LoginStates({
    required this.email,
    required this.password,
    required this.status,
    this.errorMessage,
  });

  factory LoginStates.initial() {
    return const LoginStates(
      email: '',
      password: '',
      status: LoginStatus.intial,
    );
  }

  @override
  List<Object?> get props => [email, password, status];

  LoginStates copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
