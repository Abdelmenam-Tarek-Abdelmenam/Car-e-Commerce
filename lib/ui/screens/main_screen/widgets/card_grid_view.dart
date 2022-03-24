import 'package:car_e_commerce/ui/screens/main_screen/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/dummydata/dummy_data.dart';
import '../../../../data/module/products/car.dart';

class CardGridViewer extends StatelessWidget {
  final List<Car> carList;

  CardGridViewer({required this.carList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 60.h),
      itemCount: carList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:  EdgeInsets.symmetric(vertical: 40.h),
          child: ProductCard(car: carList[index]),
        );
      },
    );
  }
}