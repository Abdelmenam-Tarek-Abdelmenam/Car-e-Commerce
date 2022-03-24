import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/theme.dart';
import '../../../../shared/widgets/custom_button.dart';

class UserScreenLayout extends StatelessWidget {
  const UserScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          recentlyViewedWidget(context),
          favoritesWidget(context),
          interestsWidget(context),
          const SizedBox()
        ],
      ),
    );
  }

  Widget recentlyViewedWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recently viewed",
          style:
              Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16.sp),
        ),
        SizedBox(
          height: 10.r,
        ),
        Center(
          child: Container(
            width: 300.r,
            height: 60.r,
            decoration: BoxDecoration(
                color: darkYellow,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  5,
                  (index) => index.isOdd
                      ? VerticalDivider(
                          thickness: 10.r,
                          color: whiteColor,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text([200, 200, 200][index ~/ 2].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: whiteColor)),
                            Text(["Cars", "motorcycle", "bike"][index ~/ 2],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: whiteColor)),
                          ],
                        )),
            ),
          ),
        )
      ],
    );
  }

  Widget favoritesWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "favorites",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16.sp),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View aLL >>",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14.sp, color: darkYellow),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5.r,
        ),
        Container(
          width: 350.r,
          height: 200.r,
          decoration: BoxDecoration(
              color: darkYellow,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.carBurst,
                color: whiteColor,
                size: 50.r,
              ),
              SizedBox(
                height: 10.r,
              ),
              Text("No favorites yet",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: whiteColor))
            ],
          ),
        ),
      ],
    );
  }

  Widget interestsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Interests",
          style:
              Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16.sp),
        ),
        SizedBox(
          height: 10.r,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _interestsList()),
      ],
    );
  }

  List<Widget> _interestsList() {
    return List.generate(
        4,
        (index) => CustomChooseButton(
            active: index == 1,
            child: index == 0
                ? Text("ALL",
                    style: TextStyle(fontSize: 15.sp, color: whiteColor))
                : Icon(
                    [
                      FontAwesomeIcons.car,
                      FontAwesomeIcons.motorcycle,
                      FontAwesomeIcons.bicycle
                    ][index - 1],
                    color: whiteColor,
                    size: 24.r,
                  ),
            onPressed: () => print("set $index")));
  }
}
