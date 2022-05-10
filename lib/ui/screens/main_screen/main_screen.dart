import 'package:car_e_commerce/bloc/bloc/data_bloc/data_status_bloc.dart';
import 'package:car_e_commerce/constants/car_brands.dart';
import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/home_app_bar.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/list_view_filter_buttons.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/loading_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
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
    // DataBaseRepository d1 = DataBaseRepository();
    // var data = d1.getVehicleFiltered(
    //   vehicleType: VehicleType.car,
    //   countryName: 'Japan',
    //   carTransmission: CarTransmission.manual,
    // );
    // data.then((value) {
    //   print('here from main screen');
    //   print(value!.length);
    //   print(value);
    // });

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
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
                  height: 55.h,
                  child: const ListViewFilterButtons(carBrands: carBrands),
                ),
                BlocBuilder<DataStatusBloc, VehicleDataState>(
                    buildWhen: (prev, next) =>
                        !listEquals(prev.vehicleData, next.vehicleData) ||
                        [
                          VehicleDataStatus.loadingData,
                          VehicleDataStatus.loadedData
                        ].contains(next.status),
                    builder: (context, state) {
                      if (state.status == VehicleDataStatus.loadingData) {
                        return Expanded(
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.5),
                                highlightColor: Colors.white,
                                child: const LoadingView()));
                      } else {
                        if (state.vehicleData.isEmpty) {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.carBurst,
                                  color: whiteColor,
                                  size: 70.r,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "No Vehicles",
                                  style: Theme.of(context).textTheme.headline2,
                                )
                              ],
                            ),
                          );
                        }
                        return Expanded(
                            child:
                                CardGridViewer(vehicleList: state.vehicleData));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
