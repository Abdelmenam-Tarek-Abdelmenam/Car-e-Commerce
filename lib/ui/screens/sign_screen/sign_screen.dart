import 'package:car_e_commerce/bloc/cubit/data_handler/data_handler_cubit.dart';
import 'package:car_e_commerce/data/module/products/car.dart';
import 'package:flutter/material.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return const MaterialPage(
      child: SignScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            int now = DateTime.now().millisecondsSinceEpoch;
            DataHandlerCubit cubit = DataHandlerCubit();
            List<Car> cars = (await cubit.getAllData()).cast();
            print((DateTime.now().millisecondsSinceEpoch - now) / 1000);
            print(cars[100].video);
            print(cars.length);
          },
          child: const Text("test"),
        ),
        appBar: AppBar(),
        body: const Text('Hey Sign'));
  }
}
