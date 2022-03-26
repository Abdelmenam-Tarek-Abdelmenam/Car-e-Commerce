import 'package:car_e_commerce/constants/fonts.dart';
import 'package:car_e_commerce/data/module/products/car.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/details_screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_mask/widget_mask.dart';

class ProductCard extends StatelessWidget {
  final Car car;

  const ProductCard({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateAndPush(context, DetailsScreen(car));
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
          // todo: mask of the card product
          Positioned(
            left: 170.w,
            bottom: 60.h,
            child: WidgetMask(
              blendMode: BlendMode.srcIn,
              childSaveLayer: true,
              child: Image.asset(
                'assets/mask/mask.png',
                width: 175.w,
              ),
              mask: Image.network(
                car.imgUrl,
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
                    car.price.toString(),
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
                        car.name.split(' ')[0],
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
                        car.name.split(' ')[1],
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
                        car.properties['Engine capacity']
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
                        car.properties['Year'] ?? "--",
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
}
