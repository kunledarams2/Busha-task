import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/custom_colors.dart';



class BaseScaffold extends StatelessWidget {
  final PreferredSize? appBar;
  final Widget Function(Size size) builder;
  final Key? scaffoldKey;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool safeTop;
  final bool safeBottom;
  final VoidCallback? onWillPop;
  final Widget? bottomNavBar;
  final bool includeHorizontalPadding;
  final Widget? floatingActionButton;
  final bool childHasCustomHeader;
  final double? horizontalPadding;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;

  const BaseScaffold({
    Key? key,
    required this.builder,
    this.appBar,
    this.scaffoldKey,
    this.backgroundColor = CustomColors.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.safeTop = true,
    this.safeBottom = true,
    this.onWillPop,
    this.bottomNavBar,
    this.includeHorizontalPadding = true,
    this.floatingActionButton,
    this.childHasCustomHeader = false,
    this.floatingActionButtonLocation,
    this.horizontalPadding,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(
      builder: (context, constraint) {
        Size constraints = Size(constraint.maxWidth, constraint.maxHeight);
        return GestureDetector(
          onTap: () {
            //unfocus any active TextField
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: backgroundColor,
            key: scaffoldKey,
            appBar: appBar,
            drawer: drawer,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            bottomNavigationBar: bottomNavBar,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            body: SafeArea(
              top: childHasCustomHeader == true ? false : safeTop,
              bottom: safeBottom,
              child: Builder(
                builder: (_) => Container(
                  width: constraints.width,
                  height: constraints.height,
                  margin: includeHorizontalPadding
                      ? EdgeInsets.symmetric(
                    horizontal: horizontalPadding ?? 20.w,
                  )
                      : EdgeInsets.zero,
                  child: builder(constraints),
                ),
              ),
            ),

          ),
        )

          /*WillPopScope(
          onWillPop: () async {
            onWillPop?.call();
            return true;
          },
          child: ,
        )*/;
      },
    );
  }
}