import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/theme.dart';

class CarCard extends StatelessWidget {
  final Vehicle vehicle;
  final NumberFormat formatter = NumberFormat.decimalPattern();

  CarCard(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                SizedBox(
                  child: SizedBox(
                    width: 150.w,
                    height: 98.h,
                    child: Image.network(
                      vehicle.imgUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (_, __, ___) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50.r,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(vehicle.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: darkGrayColor, fontSize: 16.sp)),
                Tooltip(
                  message: vehicle.name,
                  child: Text(vehicle.name.replaceAll(vehicle.brand, "").trim(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: darkGrayColor, fontSize: 14.sp)),
                ),
                Text("${formatter.format(vehicle.price)} EGP",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: darkYellow, fontSize: 15.sp)),
              ],
            ),
          ),
          Positioned(
            top: -5.h,
            left: -2.w,
            child: Visibility(
              visible: vehicle.video != "noVideo",
              child: IconButton(
                  onPressed: () {
                    launch(vehicle.video); //or any link you want
                  },
                  icon: Icon(
                    FontAwesomeIcons.youtube,
                    color: HSLColor.fromColor(Colors.red)
                        .withLightness(0.5)
                        .toColor(),
                    size: 30.r,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
