import 'package:flutter/material.dart';
import 'package:car_e_commerce/ui/screens/main_screen/widgets/filter_brand_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/bloc/data_bloc/data_status_bloc.dart';

class ListViewFilterButtons extends StatelessWidget {
  final List<String> carBrands;

  const ListViewFilterButtons({
    Key? key,
    required this.carBrands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carBrands.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return BlocBuilder<DataStatusBloc, VehicleDataState>(
          builder: (_, VehicleDataState state) => FilterBrandButton(
              brandName: carBrands[index],
              isSelected: carBrands[index] == state.brand,
              onPressed: () {
                if (index == 0 && carBrands[index] != state.brand) {
                  context
                      .read<DataStatusBloc>()
                      .add(const LoadAllVehicleData());
                } else if (carBrands[index] != "All") {
                  context
                      .read<DataStatusBloc>()
                      .add(LoadBrandVehicleData(brandName: carBrands[index]));
                }
              }),
        );
      },
    );
  }
}
