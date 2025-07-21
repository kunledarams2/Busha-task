import 'package:busha_task/shared/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../../core/theme/customText.dart';
import '../../../core/theme/custom_colors.dart';
import 'custom_margins.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    this.onTap,
  this.height, this.width,
  this.bgColor,
  this.buttonStyle,
  this.buttonLabel,
  this.borderRadius,
  this.buttonLabelColor,
    this.isButtonDisabled= true,
    this.isLoading =false,
  this.prefixIcon});
final double? height,width,borderRadius;
final Color? bgColor;
final TextStyle? buttonStyle;
final String? buttonLabel;
final Function? onTap;
final Color? buttonLabelColor;
final bool isLoading;
final bool isButtonDisabled;
final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        isButtonDisabled ? () {} :isLoading?(){}:  onTap?.call();

      },
      child: Container(
        width: width??1.sw,
        height: height??49.h,
        decoration: BoxDecoration(
          color: isButtonDisabled? CustomColors.coolGray200: bgColor??CustomColors.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius??25.r),
          border: Border.all(color: CustomColors.coolGray100)
        ),
        child: Center(
          child: isLoading ? const Center(
        child: SizedBox(
        height: 19,
            width: 19,
            child: CircularProgressIndicator(color: Colors.white))) :Row(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                prefixIcon??SizedBox.shrink(),
                XMargin(5),
                Text(
                buttonLabel??"Okay",
                style: buttonStyle??CustomTextStyle.textStyleManrope.copyWith(
                  color:isButtonDisabled? CustomColors.coolGray400:buttonLabelColor?? Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  height: 19.36.toLineHeight(16.sp),
                ),
                          ),
              ],
            ),
        ),
      ),
    );
  }
}
