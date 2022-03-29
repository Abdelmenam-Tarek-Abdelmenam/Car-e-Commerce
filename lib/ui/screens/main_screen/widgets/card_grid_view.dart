import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardGridViewer extends StatelessWidget {
  final List<Vehicle> vehicleList;
  final bool fromMain;

  const CardGridViewer(
      {Key? key, required this.vehicleList, this.fromMain = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 20.h),
      itemCount: vehicleList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: ProductCard(
            vehicle: vehicleList[index],
            index: fromMain ? index : -1,
          ),
        );
      },
    );
  }
}
