import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/list_view_filter_buttons.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/search_bar.dart';
import 'package:car_e_commerce/ui/screens/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/bloc/data_bloc/data_status_bloc.dart';
import '../../../../constants/car_brands.dart';

class MainSliverAppBar extends StatelessWidget {
  const MainSliverAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      primary: false,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      expandedHeight: 125.h,
      title: const SearchBar(),
      titleSpacing: 14.w,
      actions: [
        SizedBox(
          width: 15.w,
        ),
        ProfileIcon(
          profileHandler: () {
            context.read<DataStatusBloc>().add(const LoadAllFavData());
            navigateAndPush(context, const UserScreen());
          },
        ),
        SizedBox(
          width: 15.w,
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(top: 85.h),
        centerTitle: true,
        title: const ListViewFilterButtons(
          carBrands: carBrands,
        ),
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  final Function() profileHandler;

  const ProfileIcon({
    Key? key,
    required this.profileHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: Colors.white,
      child: InkWell(
        child: Center(
          child: Icon(
            Icons.person_outline_rounded,
            color: Colors.black,
            size: 18.r,
          ),
        ),
        onTap: profileHandler,
      ),
    );
  }
}
