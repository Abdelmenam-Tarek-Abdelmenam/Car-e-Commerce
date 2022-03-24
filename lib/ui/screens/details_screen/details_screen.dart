import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widget_mask/widget_mask.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BarIconButton(
                      icon: Icons.arrow_back_rounded,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  BarIconButton(
                      icon: Icons.logout,
                      onPressed: () {
                        print("logout");
                      }),
                ],
              ),
              SizedBox(
                height: 35.r,
              ),
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
              SizedBox(
                height: 30.r,
              ),
              Center(
                child: WidgetMask(
                  blendMode: BlendMode.srcIn,
                  childSaveLayer: true,
                  child: Image.asset(
                    "assets/images/Logo/details_mask.png",
                    width: 200.r,
                  ),
                  mask: Image.network(
                    "https://media.hatla2eestatic.com/uploads/ncarteraz/28651/big-up_d060d0807ed204a1fc18516a11257c87.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20.r,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Car Specifications ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.youtube,
                        color: Colors.red,
                        size: 40,
                      ))
                ],
              ),
              Wrap(
                children: List.generate(
                    18,
                    (index) => Column(
                          children: [
                            SvgPicture.asset(
                              "assets/images/Icons/5670420.svg",
                              width: 50,
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child: const CircularProgressIndicator()),
                              //      color: Colors.red,
                            ),
                            Text(
                              "text",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
