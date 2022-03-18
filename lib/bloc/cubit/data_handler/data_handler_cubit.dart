import 'package:bloc/bloc.dart';

import '../auth_handler/auth_handler_cubit.dart';

class DataHandlerCubit extends Cubit<AuthHandlerState> {
  DataHandlerCubit() : super(AuthHandlerInitial());
}
