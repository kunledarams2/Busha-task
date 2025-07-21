import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../core/theme/custom_colors.dart';
import '../shared/utils/custom_designs/base_scaffold.dart';
import '../shared/utils/custom_designs/custom_empty_widget.dart';

@RoutePage()
class RecipientsPage extends StatelessWidget {
  const RecipientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      includeHorizontalPadding: false,
      backgroundColor:CustomColors.backgroundColor,
      childHasCustomHeader: false,

      safeTop: true,

      builder: (size) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor:CustomColors.backgroundColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: CustomColors.lighterGrey ,
            systemNavigationBarIconBrightness: Brightness.dark,

          ),
          child:CustomEmptyWidget(),
        );
      },
    );
  }
}
