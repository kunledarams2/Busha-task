import 'package:auto_route/annotations.dart';
import 'package:busha_task/view_models/tabHost_provider.dart';
import 'package:busha_task/views/tabNavigationBar/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/custom_colors.dart';
import '../../shared/utils/custom_designs/base_scaffold.dart';


@RoutePage()
class Tabhost extends HookConsumerWidget {
  const Tabhost({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:  CustomColors.primaryColor, // Set your desired color
      statusBarIconBrightness: Brightness.light, // For white icons on a dark background
    ));
    final useTabHostViewModel = ref.watch(tabHostProvider);

    return BaseScaffold(
      includeHorizontalPadding: false,
      backgroundColor:CustomColors.backgroundColor,
      childHasCustomHeader: false,

      safeTop: false,
      safeBottom: true,
      onWillPop: () {},
      bottomNavBar: const CustomBottomNavigationBar(),
      builder: (size) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor:CustomColors.backgroundColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: CustomColors.whiteColor ,
            systemNavigationBarIconBrightness: Brightness.dark,

          ),
          child: SizedBox(
            width: 1.sw,
            height: 1.sw,
            child:useTabHostViewModel.selectedDashBoardTab.page,
          ),
        );
      },
    );
  }
}
