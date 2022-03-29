import 'package:car_e_commerce/bloc/bloc/data_bloc/data_status_bloc.dart';
import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/details_screen/details_screen.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/bottom_sheet.dart';
import 'package:car_e_commerce/ui/screens/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  Function? treu() {
    print('object');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingSearchBarAction.icon(
              icon: SvgPicture.asset('assets/icons/filter.svg'),
              onTap: () {
                showBottomSheet(context);
              }),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.w))),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              child: TypeAheadField<Vehicle>(
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                        labelText: 'Search for vehicle',
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[500],
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20.r,
                        )),
                  ),
                  hideOnError: true,
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty) {
                      return [];
                    } else {
                      return context
                          .read<DataStatusBloc>()
                          .searchVehiclesByName(pattern);
                    }
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                        leading: Image.network(suggestion.imgUrl),
                        title: Text(suggestion.name),
                        subtitle: Text(
                          ("${suggestion.price}"),
                        ));
                  },
                  onSuggestionSelected: (suggestion) {
                    navigateAndPush(context, DetailsScreen(suggestion, -2));
                  }),
            ),
          ),
          ProfileIcon(
            profileHandler: () {
              context.read<DataStatusBloc>().add(const LoadAllFavData());
              navigateAndPush(context, const UserScreen());
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        ),
        isDismissible: true,
        builder: (BuildContext context) {
          return const Filter();
        });
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
      backgroundColor: Colors.white,
      radius: 20.r,
      child: IconButton(
        iconSize: 20.r,
        color: Colors.white,
        icon: const Icon(
          Icons.person_outline_rounded,
          color: Colors.black,
        ),
        onPressed: profileHandler,
      ),
    );
  }
}
