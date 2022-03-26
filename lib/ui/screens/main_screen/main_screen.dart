import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/cubit/data_handler/data_handler_cubit.dart';
import 'widgets/card_grid_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return const MaterialPage(
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
              FutureBuilder<List<Vehicle>>(

                  /// for seeing real data only
                  future: DataHandlerCubit().getAllData(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                          child:
                              CardGridViewer(carList: snapshot.data!.cast()));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
