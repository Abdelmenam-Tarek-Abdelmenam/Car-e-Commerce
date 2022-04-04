import 'package:car_e_commerce/bloc/bloc/data_bloc/data_status_bloc.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'search_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchBar()),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
