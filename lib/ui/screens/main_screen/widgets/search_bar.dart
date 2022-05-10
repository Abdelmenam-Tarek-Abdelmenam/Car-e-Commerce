import 'package:car_e_commerce/bloc/bloc/data_bloc/data_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/bottom_sheet.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // final TextEditingController _searchedText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 305.w,
      child: TextFormField(
        enableSuggestions: true,
        onChanged: (value) {
          context.read<DataStatusBloc>().add(SearchByName(value));
        },
        // controller: _searchedText,
        decoration: InputDecoration(
          // ! we need here to remove the padding of the suffix icon
          suffixIcon: InkWell(
            onTap: () => showBottomSheet(context),
            child: SvgPicture.asset(
              'assets/icons/filter.svg',
              fit: BoxFit.scaleDown,
              height: 5,
              width: 5,
            ),
          ),
          constraints: BoxConstraints(maxHeight: 35.h, maxWidth: 305.w),
          // suffixIconConstraints: const BoxConstraints( max 40, 30),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(12.w, 2.h, 0, 0),
          fillColor: Colors.white,
          hintText: 'Search for the product here ',
          hintStyle: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
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
