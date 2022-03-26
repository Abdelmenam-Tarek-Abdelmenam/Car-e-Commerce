import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/dummydata/dummy_data.dart';
import '../../../data/module/products/car.dart';
import 'widgets/card_grid_view.dart';

class MainScreen extends StatelessWidget {
  final List<Car> dummyCarList = carList;
  MainScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return MaterialPage(
      child: MainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: themeGradient),
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            children: [
              const HomeAppBar(),
              SizedBox(
                height: 40.h,
              ),
              Expanded(child: CardGridViewer(carList: dummyCarList)),
            ],
          ),
        ),
      ),
    );
  }
}
