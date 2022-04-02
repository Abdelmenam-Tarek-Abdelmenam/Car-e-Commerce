import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/fonts.dart';

class FilterBrandButton extends StatefulWidget {
  String brandName;

  FilterBrandButton({
    this.brandName = "All",
  });

  @override
  State<FilterBrandButton> createState() => _FilterBrandButtonState();
}

class _FilterBrandButtonState extends State<FilterBrandButton> {
  bool isSelected = false;

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
      width: 55.r,
      height: 55.r,
      child: widget.brandName == "All"
          ? TextButton(
              onPressed: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              child: Text(
                widget.brandName,
                style: textTheme.button
                    ?.copyWith(fontSize: 20.sp, color: Colors.white),
              ),
            )
          : IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                'assets/car brands/${widget.brandName}.svg',
                width: 35.w,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              // iconSize: 50.r,
            ),
    );
  }
}
