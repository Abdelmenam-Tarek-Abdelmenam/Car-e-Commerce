import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget {
  void pressedTest() {
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingSearchBarAction.icon(
              icon: SvgPicture.asset('assets/icons/filter.svg'), onTap: () {}),
          ProfileIcon(
            profileHandeler: pressedTest,
          ),
        ],
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  final VoidCallback profileHandeler;

  ProfileIcon({
    required this.profileHandeler,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 20.r,
      child: IconButton(
        icon: Icon(
          Icons.person_outline_rounded,
          size: 20.w,
          color: Colors.black,
        ),
        onPressed: profileHandeler,
      ),
    );
  }
}
