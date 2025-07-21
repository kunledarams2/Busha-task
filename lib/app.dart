import 'package:busha_task/routes/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/locator.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = locator<AppRouter>();
    final themeMode = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: appRouter.config(),
          debugShowCheckedModeBanner: false,
          title: "",
          theme: AppTheme.light,
          themeMode: themeMode,
          builder: (context, widget) {
            return Navigator(
              onGenerateRoute: (settings) => CupertinoPageRoute(
                builder: (context) => widget!,
              ),
            );
          },
        );
      },
    );
  }
}
