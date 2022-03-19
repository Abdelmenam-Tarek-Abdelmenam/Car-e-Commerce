import 'package:car_e_commerce/data/local/pref_repository.dart';
import 'package:car_e_commerce/data/local/sql_database.dart';
import 'package:car_e_commerce/ui/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc/auth_status_bloc.dart';
import 'bloc/my_bloc_observer.dart';
import 'data/repository/auth_repository.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFDFF8FE),
    statusBarIconBrightness: Brightness.dark,
  ));

  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await DataBaseRepository.initializeDataBase();
      await PreferenceRepository.initializePreference();
      AuthRepository auth = AuthRepository();
      runApp(MyApp(
        auth: auth,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  AuthRepository auth;
  MyApp({
    Key? key,
    required this.auth,
  }) : super(key: key);
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
      debugShowCheckedModeBanner: false,
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
