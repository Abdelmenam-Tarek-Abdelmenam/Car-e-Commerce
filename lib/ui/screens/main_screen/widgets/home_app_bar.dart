import 'package:car_e_commerce/constants/countries_list.dart';
import 'package:car_e_commerce/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget {
  Function? treu() {
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
              icon: SvgPicture.asset('assets/icons/filter.svg'),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r)),
                    ),
                    isDismissible: true,
                    builder: (BuildContext context) {
                      return Filter();
                    });
              }),
          ProfileIcon(
            profileHandeler: () => treu(),
          ),
        ],
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  final Function profileHandeler;

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
        onPressed: () => profileHandeler,
      ),
    );
  }
}

class Filter extends StatelessWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Manufacture country',
                  style: textTheme.headline3?.copyWith(color: Colors.black)),
              ManfactureCountriesDropDownMenu(),
            ],
          ),
          Text('Price',
              style: textTheme.headline3?.copyWith(color: Colors.black)),
          SizedBox(height: 8.h),
          Slider(division: 20, max: 300, min: 0, defaultValues: []),
          SizedBox(height: 18.h),
          Text('Production year',
              style: textTheme.headline3?.copyWith(color: Colors.black)),
          SizedBox(height: 8.h),
          Slider(division: 20, max: 300, min: 0, defaultValues: []),
          SizedBox(height: 18.h),
          Text('Engine Capacity',
              style: textTheme.headline3?.copyWith(color: Colors.black)),
          SizedBox(height: 8.h),
          Slider(division: 20, max: 300, min: 0, defaultValues: []),
          SizedBox(height: 16.h),
          Text('Transmission Type',
              style: textTheme.headline3?.copyWith(color: Colors.black)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              FliterShowBtn(),
              ClearBtn(),
            ],
          ),
        ],
      ),
    );
  }
}

class FliterShowBtn extends StatelessWidget {
  const FliterShowBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 40.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Show Results', style: textTheme.subtitle2),
      ),
    );
  }
}

class ClearBtn extends StatelessWidget {
  const ClearBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Clear',
        style: textTheme.subtitle1,
      ),
    );
  }
}

// ! I have problem in the constructor of the slider the default values
// todo:: edit the position of the label to be at the top of the slider
class Slider extends StatefulWidget {
  final int min;
  final int max;
  final int division;
  final List<int> defaultValues;
  Slider(
      {required this.min,
      required this.max,
      required this.division,
      required this.defaultValues});
  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  RangeValues value = RangeValues(10, 200);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        thumbColor: Color(0xFFF4B301),
        inactiveTrackColor: Color(0xffEDEEF1),
        activeTrackColor: Color(0xFFF4B301),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
      ),
      child: RangeSlider(
        onChanged: (RangeValues value) => setState(() {
          this.value = value;
        }),
        labels: RangeLabels(value.start.toString(), value.end.toString()),
        values: value,
        max: widget.max.toDouble(),
        min: widget.min.toDouble(),
        divisions: widget.division,
      ),
    );
  }
}

// todo:: change the style
class ManfactureCountriesDropDownMenu extends StatefulWidget {
  @override
  State<ManfactureCountriesDropDownMenu> createState() =>
      _ManfactureCountriesDropDownMenuState();
}

class _ManfactureCountriesDropDownMenuState
    extends State<ManfactureCountriesDropDownMenu> {
  var contriesList = countriesList;

  String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      child: DropdownButton(
        isExpanded: true,
        value: value,
        items: contriesList.map((e) => buildMenu(e)).toList(),
        onChanged: (String? value) {
          setState(() {
            this.value = value;
          });
        },
      ),
    );
  }

  DropdownMenuItem<String> buildMenu(String item) {
    return DropdownMenuItem(
      child: Text(
        item,
      ),
      value: item,
    );
  }
}

// todo:: 1- Radio btns at the end
