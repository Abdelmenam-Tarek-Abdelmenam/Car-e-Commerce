import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/fonts.dart';

// ignore: must_be_immutable
class FilterBrandButton extends StatelessWidget {
  final String brandName;
  bool isSelected;
  Function() onPressed;

  FilterBrandButton({
    Key? key,
    this.brandName = "All",
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: isSelected
            ? Theme.of(context).iconTheme.color
            : Theme.of(context).colorScheme.secondary,
      ),
      width: 45.w,
      height: 55.r,
      child: brandName == "All"
          ? TextButton(
              onPressed: onPressed,
              child: Text(
                brandName,
                textAlign: TextAlign.center,
                style: textTheme.button
                    ?.copyWith(fontSize: 14.sp, color: Colors.white),
              ),
            )
          : IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                'assets/car brands/$brandName.svg',
                width: 25.w,
                color: Colors.white,
              ),
              onPressed: onPressed,
              // iconSize: 50.r,
            ),
    );
  }
}
