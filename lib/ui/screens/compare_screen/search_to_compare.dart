import 'package:car_e_commerce/data/module/products/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../bloc/bloc/data_bloc/data_status_bloc.dart';
import '../../routes/navigation_functions.dart';
import 'compare_screen.dart';

class SearchToCompare extends StatelessWidget {
  final Vehicle vehicle;
  const SearchToCompare(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              Navigator.of(context).pop();
              navigateAndPush(
                  context,
                  CompareScreen(
                    firstVehicle: vehicle,
                    secondVehicle: suggestion,
                  ));
            }),
      ),
    );
  }
}
