import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/user_screen/widgets/fav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../bloc/bloc/data_bloc/data_status_bloc.dart';
import '../../../../constants/theme.dart';
import '../../../../data/local/pref_repository.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/toast_helper.dart';
import '../../main_screen/widgets/loading_card.dart';
import '../../main_screen/widgets/product_card.dart';

// ignore: must_be_immutable
class UserScreenLayout extends StatelessWidget {
  UserScreenLayout({Key? key}) : super(key: key) {
    viewedCars = (PreferenceRepository.getDataFromSharedPreference(
                key: VehicleType.car.name) ??
            [])
        .length;
    viewedMotorCycle = (PreferenceRepository.getDataFromSharedPreference(
                key: VehicleType.motorCycle.name) ??
            [])
        .length;
  }

  late int viewedCars;
  late int viewedMotorCycle;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 40.h,
            ),
            recentlyViewedWidget(context),
            SizedBox(
              height: 20.h,
            ),
            favoritesWidget(context),
            SizedBox(
              height: 20.h,
            ),
            interestsWidget(context),
          ],
        ),
      ),
    );
  }

  Widget recentlyViewedWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recently viewed",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 16.sp, color: darkGrayColor),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Container(
            width: 300.w,
            height: 60.h,
            decoration: BoxDecoration(
                color: darkYellow,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  5,
                  (index) => index.isOdd
                      ? VerticalDivider(
                          thickness: 10.r,
                          color: whiteColor,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                [viewedCars, viewedMotorCycle, "--"][index ~/ 2]
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: whiteColor)),
                            Text(["Cars", "motorcycle", "bike"][index ~/ 2],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: whiteColor)),
                          ],
                        )),
            ),
          ),
        )
      ],
    );
  }

  Widget favoritesWidget(BuildContext context) {
    return BlocBuilder<DataStatusBloc, VehicleDataState>(
        builder: (context, state) {
      if (state.status == VehicleDataStatus.loadingFav) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "favorites",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 16.sp, color: darkGrayColor),
                ),
                TextButton(
                  onPressed: () {
                    showToast("Wait the data to load", type: ToastType.info);
                  },
                  child: Text(
                    "View aLL >>",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 14.sp, color: darkYellow),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: 350.w,
              height: 200.h,
              decoration: BoxDecoration(
                  gradient: themeGradient,
                  borderRadius: BorderRadius.all(Radius.circular(15.r))),
              child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: const LoadingView(count: 1)),
            ),
          ],
        );
      } else {
        if (state.favData.isEmpty) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "favorites",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 16.sp, color: darkGrayColor),
                  ),
                  TextButton(
                    onPressed: () {
                      showToast("no favorites yet", type: ToastType.info);
                    },
                    child: Text(
                      "View aLL >>",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14.sp, color: darkYellow),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 350.w,
                height: 200.h,
                decoration: BoxDecoration(
                    gradient: themeGradient,
                    borderRadius: BorderRadius.all(Radius.circular(15.r))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.carBurst,
                      color: whiteColor,
                      size: 50.r,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("No favorites yet",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: whiteColor))
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "favorites",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 16.sp, color: darkGrayColor),
                  ),
                  Visibility(
                    visible: state.favData.length > 5,
                    child: TextButton(
                      onPressed: () {
                        navigateAndPush(context, const FavScreen());
                      },
                      child: Text(
                        "View aLL >>",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 14.sp, color: darkYellow),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 350.w,
                height: 200.h,
                decoration: BoxDecoration(
                    gradient: themeGradient,
                    borderRadius: BorderRadius.all(Radius.circular(15.r))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: controller, // PageController
                          itemBuilder: (_, index) => Padding(
                                padding: EdgeInsets.only(top: 40.h),
                                child: ProductCard(
                                  vehicle: state.favData[index],
                                  index: -1,
                                ),
                              ),
                          itemCount: state.favData.length > 5
                              ? 5
                              : state.favData.length),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        controller: controller, // PageController
                        count:
                            state.favData.length > 5 ? 5 : state.favData.length,
                        effect: WormEffect(
                            dotHeight: 8.r,
                            dotWidth: 8.r,
                            dotColor: whiteColor,
                            activeDotColor:
                                darkGrayColor), // your preferred effect
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      }
    });
  }

  Widget interestsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Interests",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 16.sp, color: darkGrayColor),
        ),
        SizedBox(
          height: 10.h,
        ),
        interestsList()
      ],
    );
  }

  Widget interestsList() {
    return BlocBuilder<DataStatusBloc, VehicleDataState>(
      buildWhen: (prev, next) =>
          next.status == VehicleDataStatus.changeSomeData,
      builder: (context, state) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                4,
                (index) => CustomChooseButton(
                    active: index == state.type.index,
                    child: index == 0
                        ? Text("ALL",
                            style:
                                TextStyle(fontSize: 15.sp, color: whiteColor))
                        : Icon(
                            [
                              FontAwesomeIcons.car,
                              FontAwesomeIcons.motorcycle,
                              FontAwesomeIcons.bicycle
                            ][index - 1],
                            color: whiteColor,
                            size: 24.r,
                          ),
                    onPressed: () {
                      if ([1, 2].contains(index)) {
                        context
                            .read<DataStatusBloc>()
                            .add(EditVehicleType(VehicleType.values[index]));
                        PreferenceRepository.putDataInSharedPreference(
                            value: index, key: "type");
                      } else {
                        showToast("not yet");
                      }
                    })));
      },
    );
  }
}
