import 'package:car_e_commerce/constants/fonts.dart';
import 'package:car_e_commerce/data/local/pref_repository.dart';
import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/details_screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:widget_mask/widget_mask.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final Vehicle vehicle;
  final int index;
  NumberFormat formatter = NumberFormat.decimalPattern();

  ProductCard({
    Key? key,
    required this.vehicle,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateAndPush(context, DetailsScreen(vehicle, index));
        increaseCarCounter();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 130.h,
            width: 350.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.white,
            ),
          ),
          // image
          Positioned(
            left: 170.w,
            bottom: 60.h,
            child: WidgetMask(
              blendMode: BlendMode.srcIn,
              childSaveLayer: true,
              child: Image.asset(
                'assets/mask/mask2.png',
                width: 175.w,
              ),
              mask: Image.network(
                vehicle.imgUrl,
                width: 175.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.image_not_supported_outlined,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          // price of the product
          Positioned(
            top: -25.h,
            left: 30.w,
            child: Container(
              padding: EdgeInsets.all(4.r),
              width: 90.w,
              height: 65.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  Text(
                    formatter.format(vehicle.price),
                    style: textTheme.headline3,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Price',
                    style: textTheme.headline3,
                  )
                ],
              ),
            ),
          ),

          // show the specs of the product
          Positioned(
            bottom: 12.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brand",
                        style:
                            textTheme.headline3?.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        vehicle.name.split(' ')[0],
                        style:
                            textTheme.subtitle2?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(width: 35.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Model",
                        style:
                            textTheme.headline3?.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        vehicle.name.split(' ')[1],
                        style:
                            textTheme.subtitle2?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(width: 35.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Engine",
                        style:
                            textTheme.headline3?.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        vehicle.properties['Engine capacity']
                                ?.split("-")[0]
                                .trim() ??
                            "--",
                        style:
                            textTheme.subtitle2?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(width: 35.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Year",
                        style:
                            textTheme.headline3?.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        vehicle.properties['Year']?.replaceAll("Year", "") ??
                            "--",
                        style:
                            textTheme.subtitle2?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void increaseCarCounter() async {
    List<String> viewedCars =
        PreferenceRepository.pref.getStringList(vehicle.typeVehicle.name) ?? [];
    viewedCars.add(vehicle.id);
    viewedCars = viewedCars.toSet().toList();
    PreferenceRepository.putDataInSharedPreference(
        value: viewedCars, key: vehicle.typeVehicle.name);
  }
}
