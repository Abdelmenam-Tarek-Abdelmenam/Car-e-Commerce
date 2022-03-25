import 'package:car_e_commerce/ui/screens/details_screen/widgets/car_spec.dart';
import 'package:car_e_commerce/ui/screens/details_screen/widgets/details_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/theme.dart';
import '../../../shared/widgets/bar_icon_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: themeGradient),
          padding: EdgeInsets.all(20.r),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              appBar(context),
              SizedBox(
                height: 35.h,
              ),
              nameAndPrice(context),
              SizedBox(
                height: 30.h,
              ),
              // ViewPhoto
              const DetailsPhoto(
                  "https://media.hatla2eestatic.com/uploads/ncarteraz/28651/big-up_d060d0807ed204a1fc18516a11257c87.jpg"),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Car Specifications ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1),
                  IconButton(
                      onPressed: () {
                        launch(
                            'https://youtu.be/QN-6MNc39Dg'); //or any link you want
                      },
                      icon: Icon(
                        FontAwesomeIcons.youtube,
                        color: HSLColor.fromColor(Colors.red)
                            .withLightness(0.5)
                            .toColor(),
                        size: 40.r,
                      )),
                ],
              ),
              const CarSpec()
            ]),
          ),
        ),
      ),
    );
  }

  Widget nameAndPrice(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Mercedes E 300 2020 A/T / AMG",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 20.sp)),
          SizedBox(
            height: 4.r,
          ),
          Text("200,000 EGP",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1),
        ],
      );

  Widget appBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BarIconButton(
              icon: Icons.arrow_back_rounded,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          BarIconButton(
              icon: FontAwesomeIcons.heart,
              onPressed: () {
                print("logout");
              }),
        ],
      );
}
