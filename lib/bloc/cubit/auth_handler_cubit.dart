import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_handler_state.dart';

class AuthHandlerCubit extends Cubit<AuthHandlerState> {
  AuthHandlerCubit() : super(AuthHandlerInitial());
}