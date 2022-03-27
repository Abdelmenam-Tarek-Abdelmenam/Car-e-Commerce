import 'package:flutter/material.dart';
import '../../bloc/bloc/auth_bloc/auth_status_bloc.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/starting_screen/login_screen/login_screen.dart';

List<Page> routes(
  AuthStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthStatus.authed:
      return [MainScreen.pageRoute()];
    case AuthStatus.unauthed:
      return [LoginScreen.pageRoute()];
  }
}
