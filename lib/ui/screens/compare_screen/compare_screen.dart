import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:car_e_commerce/ui/screens/compare_screen/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../constants/theme.dart';
import '../../../shared/widgets/bar_icon_button.dart';

// ignore: must_be_immutable
class CompareScreen extends StatelessWidget {
  final Vehicle firstVehicle;
  final Vehicle secondVehicle;
  late List<String> probertiesInfo = [];
  final NumberFormat formatter = NumberFormat.decimalPattern();

  CompareScreen(
      {required this.firstVehicle, required this.secondVehicle, Key? key})
      : super(key: key) {
    probertiesInfo.addAll(firstVehicle.properties.keys);
    probertiesInfo.addAll(secondVehicle.properties.keys);
    probertiesInfo = probertiesInfo.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(gradient: themeGradient),
                padding: EdgeInsets.all(20.r),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appBar(context),
                        SizedBox(
                          height: 35.h,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CarCard(firstVehicle),
                                CarCard(secondVehicle),
                              ],
                            ),
                            vsBox(context),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Cars Specifications ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 18.sp)),
                        SizedBox(
                          height: 20.h,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: probBuilder,
                            separatorBuilder: (_, __) => SizedBox(
                                  height: 20.h,
                                ),
                            itemCount: probertiesInfo.length)
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget probBuilder(BuildContext context, int index) {
    String prob = probertiesInfo[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          (firstVehicle.properties[prob] ?? "-").trim(),
          style: Theme.of(context).textTheme.caption,
        ),
        Tooltip(
          message: prob,
          preferBelow: false,
          child: SvgPicture.asset(
            "assets/images/Icons/${prob.replaceAll("/", "")}.svg",
            width: 35.w,
            placeholderBuilder: (BuildContext context) => Container(
                padding: EdgeInsets.all(30.r),
                child: const Icon(Icons.car_repair)),
            //      color: Colors.red,
          ),
        ),
        Text(
          (secondVehicle.properties[prob] ?? "-").trim(),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  Widget appBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BarIconButton(
              icon: Icons.arrow_back_rounded,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );

  Widget vsBox(BuildContext context) => Container(
        width: 60.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: darkGrayColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r)),
        ),
        child: Center(
          child: Text("VS",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, fontSize: 16.sp)),
        ),
      );
}
