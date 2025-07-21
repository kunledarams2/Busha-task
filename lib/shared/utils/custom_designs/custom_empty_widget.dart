import 'package:busha_task/shared/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/customText.dart';
import '../../../core/theme/custom_colors.dart';
import 'custom_margins.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('empty_state'.svgPath,),
          YMargin(10),
          Text("When you perform a transaction,\n you can track it here",
            textAlign: TextAlign.center,
            style: CustomTextStyle.textStyleManrope.copyWith(
                color: CustomColors.coolGray700,
                fontSize:13.h,
                fontWeight: FontWeight.w400
              // height: 1.8

            ),),
          YMargin(40),
        ],
      ),
    );
  }
}
