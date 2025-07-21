import 'package:busha_task/shared/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../../../core/theme/app_theme.dart';
import '../../../core/theme/customText.dart';

import '../../../core/theme/custom_colors.dart';
import '../../../models/dashboard_tab_data_model/dashboard_tab_model.dart';
import '../../../view_models/tabHost_provider.dart';


class CustomBottomNavigationBar extends HookConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useTabHostViewModel = ref.watch(tabHostProvider);
    return  SafeArea(
      child: Container(
        width: 1.sw,
        height: 70.h,
        decoration: BoxDecoration(color: CustomColors.whiteColor,
        /*    boxShadow: [
          BoxShadow(
              color: CustomColors.coolGray500,
              blurRadius: 5,
              offset: const Offset(0, 3))
        ]*/),
        child: ListView.builder(itemBuilder: (context,index){

          return CustomNavigationBarItem(isSelected: useTabHostViewModel.selectedDashBoardTab.tabName==useTabHostViewModel.dashBoardTabsData[index].tabName,
              dashBoardTabModel:useTabHostViewModel.dashBoardTabsData[index],
              onTap: (tabData) async {
      
            useTabHostViewModel.selectedDashBoardTab=tabData;
              });
        },
        itemCount: useTabHostViewModel.dashBoardTabsData.length,
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,),
      ),
    );
  }
}

class CustomNavigationBarItem extends HookConsumerWidget {
  const CustomNavigationBarItem(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.dashBoardTabModel});

  final bool isSelected;
  final Function(DashBoardTabModel) onTap;
  final DashBoardTabModel dashBoardTabModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (){
        onTap(dashBoardTabModel);
      },
      child: Container(
        height: 93.h,
        width: 0.35.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              dashBoardTabModel.iconUrl.svg,
              height: 20.h,
              colorFilter: ColorFilter.mode(isSelected ? CustomColors.primaryColor :CustomColors.coolGray500,
                  BlendMode.srcIn),
            ).paddingOnly(bottom: 1.h),
            Text(
              dashBoardTabModel.tabName,
              style: CustomTextStyle.textStyleManrope.copyWith(
                  color: isSelected?CustomColors.primaryColor:CustomColors.coolGray500,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 21.78.toLineHeight(18.sp)),
            )
          ],
        ),
      ),
    );
  }
}
