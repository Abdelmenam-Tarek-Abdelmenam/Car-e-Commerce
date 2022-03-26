import 'package:car_e_commerce/constants/countries_list.dart';
import 'package:car_e_commerce/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              const ManfactureCountriesDropDownMenu(),
            ],
          ),
          Text('Price',
              style: textTheme.headline3?.copyWith(color: Colors.black)),
          SizedBox(height: 8.h),
          // const Slider(division: 20, max: 300, min: 0, defaultValues: []),
          // SizedBox(height: 18.h),
          // Text('Production year',
          //     style: textTheme.headline3?.copyWith(color: Colors.black)),
          // SizedBox(height: 8.h),
          // const Slider(division: 20, max: 300, min: 0, defaultValues: []),
          // SizedBox(height: 18.h),
          // Text('Engine Capacity',
          //     style: textTheme.headline3?.copyWith(color: Colors.black)),
          // SizedBox(height: 8.h),
          const Slider(division: 20, max: 300, min: 0, defaultValues: []),
          SizedBox(height: 16.h),
          Text('Transmission Type',
              style: textTheme.headline3?.copyWith(color: Colors.black)),
          chooseTransmissionTypeBtnsView(),

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
    return SizedBox(
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
  const Slider(
      {Key? key,
      required this.min,
      required this.max,
      required this.division,
      required this.defaultValues})
      : super(key: key);
  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  RangeValues value = const RangeValues(10, 200);

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
  const ManfactureCountriesDropDownMenu({Key? key}) : super(key: key);

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
    return SizedBox(
      width: 120.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
              color: Theme.of(context).primaryColor, style: BorderStyle.solid, width: 0.80),
        ),
        child: DropdownButton(
          underline: const SizedBox(),
          isExpanded: true,
          value: value,
          hint: const Text('All'),
          items: contriesList.map((e) => buildMenu(e)).toList(),
          onChanged: (String? value) {
            setState(() {
              this.value = value;
            });
          },
        ),
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

class chooseTransmissionTypeBtn extends StatefulWidget {
  final String text;
  final int indexBtn;
  int selectedBtn;

  chooseTransmissionTypeBtn(this.text, this.indexBtn, this.selectedBtn);
  bool get _selected => indexBtn == selectedBtn;

  @override
  State<chooseTransmissionTypeBtn> createState() =>
      _chooseTransmissionTypeBtnState();
}

class _chooseTransmissionTypeBtnState extends State<chooseTransmissionTypeBtn> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: SizedBox(
        width: 70.w,
        height: 25.h,
        child: Align(
          alignment: Alignment.center,
          child: Text(widget.text,
              style: textTheme.subtitle2!.copyWith(fontSize: 13.sp)),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      selected: _selected,
      selectedColor: Theme.of(context).primaryColor,
      onSelected: (select) {
        setState(() {
          _selected = select;
        });
        print(_selected);
      },
    );
  }
}

class chooseTransmissionTypeBtnsView extends StatefulWidget {
  const chooseTransmissionTypeBtnsView({Key? key}) : super(key: key);

  @override
  State<chooseTransmissionTypeBtnsView> createState() =>
      _chooseTransmissionTypeBtnsViewState();
}

class _chooseTransmissionTypeBtnsViewState
    extends State<chooseTransmissionTypeBtnsView> {
  late int selectedBtn = 2;

  @override
  Widget build(BuildContext context) {
    List<chooseTransmissionTypeBtn> btns = [
      chooseTransmissionTypeBtn('All', 0, selectedBtn),
      chooseTransmissionTypeBtn('Manual', 1, selectedBtn),
      chooseTransmissionTypeBtn('Automatic', 2, selectedBtn),
    ];
    print('$selectedBtn in Radio State');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        btns[0],
        btns[1],
        btns[2],
      ],
    );
  }
}