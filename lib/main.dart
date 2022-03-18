import 'package:car_e_commerce/ui/routes/routes.dart';
import 'package:car_e_commerce/ui/screens/main_screen/main_screen.dart';
import 'package:car_e_commerce/ui/screens/sign_screen/sign_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/auth_status_bloc.dart';
import 'bloc/myBlocObserver.dart';
import 'data/repository/auth_repository.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final auth = AuthRepository();
      runApp(MyApp(
        auth: auth,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  AuthRepository auth;
  MyApp({
    required this.auth,
  });
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: auth,
      child: BlocProvider(
        create: (_) => AuthStatusBloc(
          auth,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthStatusBloc bloc) => bloc.state.status),
        onGeneratePages: routes,
      ),
    );
  }
}
