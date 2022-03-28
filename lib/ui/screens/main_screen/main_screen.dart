import 'package:car_e_commerce/bloc/bloc/data_bloc/data_status_bloc.dart';
import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              BlocBuilder<DataStatusBloc, VehicleDataState>(
                  buildWhen: (prev, next) => [
                        VehicleDataStatus.loadingData,
                        VehicleDataStatus.loadedData
                      ].contains(next.status),
                  builder: (context, state) {
                    if (state.status == VehicleDataStatus.loadingData) {
                      return const CircularProgressIndicator();
                    } else if (state.status == VehicleDataStatus.loadedData) {
                      return Expanded(
                          child: CardGridViewer(
                              carList: state.vehicleData.cast()));
                    } else {
                      return const Text("undefined state");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
