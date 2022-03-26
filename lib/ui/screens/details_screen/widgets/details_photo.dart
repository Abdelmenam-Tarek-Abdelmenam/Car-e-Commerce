import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/details_screen/widgets/view_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_mask/widget_mask.dart';

class DetailsPhoto extends StatelessWidget {
  const DetailsPhoto(this.photoUrl, {Key? key}) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => navigateAndPush(context, ViewPhoto(photoUrl)),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Opacity(
                  child: Image.asset(
                    "assets/images/Logo/details_mask.png",
                    color: Colors.black87,
                    width: 200.w,
                  ),
                  opacity: 0.4),
            ),
            WidgetMask(
              blendMode: BlendMode.srcIn,
              childSaveLayer: true,
              child: Image.asset(
                "assets/images/Logo/details_mask.png",
                width: 200.w,
              ),
              mask: Image.network(
                photoUrl,
                fit: BoxFit.fill,
                width: 200.w,
                errorBuilder: (_, __, ___) {
                  return Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50.r,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
