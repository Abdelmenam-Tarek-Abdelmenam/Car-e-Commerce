import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarSpec extends StatelessWidget {
  const CarSpec({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: List.generate(
        18,
        (index) => specBuilder(index, context),
      ),
    );
  }

  Widget specBuilder(int index, BuildContext context) => Column(
        children: [
          SvgPicture.asset(
            "assets/images/Icons/5670420.svg",
            width: 35,
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
            //      color: Colors.red,
          ),
          Text(
            "automatic",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}
