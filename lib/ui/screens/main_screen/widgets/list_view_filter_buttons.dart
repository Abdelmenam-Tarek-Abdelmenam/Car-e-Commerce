import 'package:flutter/material.dart';

import 'package:car_e_commerce/constants/car_brands.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/filter_brand_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewFilterButtons extends StatelessWidget {
  List<String> carBrands;
  ListViewFilterButtons({
    required this.carBrands,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carBrands.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return FilterBrandButton(
          brandName: carBrands[index],
        );
      },
    );
  }
}
