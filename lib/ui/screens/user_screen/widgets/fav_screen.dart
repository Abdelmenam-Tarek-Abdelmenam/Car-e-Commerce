import 'package:car_e_commerce/bloc/bloc/data_bloc/data_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/theme.dart';
import '../../../shared/widgets/bar_icon_button.dart';
import '../../main_screen/widgets/card_grid_view.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(gradient: themeGradient),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 22.5.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BarIconButton(
                            icon: Icons.arrow_back_rounded,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  ),
                  CardGridViewer(
                    vehicleList:
                        context.watch<DataStatusBloc>().state.favData.cast(),
                    fromMain: false,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
