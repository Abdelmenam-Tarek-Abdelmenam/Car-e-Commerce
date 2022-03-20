import 'package:car_e_commerce/bloc/bloc/auth_status_bloc.dart';
import 'package:flutter/material.dart';

import '../screens/app_start_screen/on_boarding/on_boarding_page.dart';
import '../screens/main_screen/main_screen.dart';

List<Page> routes(
  AuthStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthStatus.authed:
      return [MainScreen.pageRoute()];
    case AuthStatus.unauthed:
      return [OnBoardingScreen.pageRoute()];
  }
}
