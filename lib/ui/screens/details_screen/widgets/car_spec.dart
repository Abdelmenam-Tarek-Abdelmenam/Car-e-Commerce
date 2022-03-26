import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarSpec extends StatelessWidget {
  final Map<String, dynamic> properties;

  const CarSpec(this.properties, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 2.h,
      crossAxisSpacing: 10.w,
      crossAxisCount: 3,
      children: List.generate(
        properties.length,
        (index) => specBuilder(index, context),
      ),
    );
  }

  Widget specBuilder(int index, BuildContext context) => Column(
        children: [
          Tooltip(
            message: properties.keys.toList()[index],
            preferBelow: false,
            child: SvgPicture.asset(
              "assets/images/Icons/${properties.keys.toList()[index].replaceAll("/", "")}.svg",
              width: 35.w,
              placeholderBuilder: (BuildContext context) => Container(
                  padding: EdgeInsets.all(30.r),
                  child: const Icon(Icons.car_repair)),
              //      color: Colors.red,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            properties.values.toList()[index].trim(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}
