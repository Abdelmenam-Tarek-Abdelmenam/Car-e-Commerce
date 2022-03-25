import 'package:car_e_commerce/shared/widgets/bar_icon_button.dart';
import 'package:car_e_commerce/ui/screens/user_screen/widgets/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/theme.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(gradient: themeGradient),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 85.h, right: 20.w),
                child: CircleAvatar(
                  radius: 55.r,
                  backgroundColor: whiteColor,
                  child: userPhoto(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0.w, top: 125.h),
              child: SizedBox(
                width: 205.w,
                child: Text("Abdelmenam Tarek Abdelmenam Elbahy",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: whiteColor, fontSize: 18.sp)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 160.h),
              child: SizedBox(
                width: 205.r,
                child: Text("moneam.elbahy@gmail.com",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 180.h),
              child: const UserScreenLayout(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(22.5.r),
                child: Row(
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userPhoto({String? url}) {
    url = url ??
        "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D";
    return ClipOval(
      child: FadeInImage.assetNetwork(
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 100),
        width: 100.w,
        placeholder: 'assets/images/Logo/avatar.png',
        imageErrorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return Image.asset(
            'assets/images/Logo/avatar.png',
            width: 100.w,
            fit: BoxFit.fill,
          );
        },
        image: url,
      ),
    );
  }
}
