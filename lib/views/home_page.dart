import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:busha_task/routes/__export__.dart';
import 'package:busha_task/shared/utils/assets.dart';
import 'package:busha_task/shared/utils/extensions.dart';
import 'package:busha_task/views/drawer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/di/locator.dart';
import '../core/theme/customText.dart';
import '../core/theme/custom_colors.dart';
import '../routes/page_router_builder.dart';
import '../shared/utils/custom_designs/base_scaffold.dart';
import '../shared/utils/custom_designs/custom_margins.dart';
import 'custom_avatar_transition.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
   HomePage({super.key});

  final GlobalKey _avatarKey = GlobalKey();
  //
  // Offset getAvatarOffset(BuildContext context) {
  //   final box = avatarKey.currentContext?.findRenderObject() as RenderBox?;
  //   if (box != null) {
  //     final position = box.localToGlobal(Offset.zero);
  //     final size = MediaQuery.of(context).size;
  //     return Offset(position.dx / size.width, position.dy / size.height);
  //   }
  //   return Offset.zero;
  // }

   // final renderBox = _avatarKey.currentContext!.findRenderObject() as RenderBox;
   // final position = renderBox.localToGlobal(Offset.zero);
   // final size = renderBox.size;
   final avatarOffset = Offset(0.005, 0.005); // top-left like placement

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final avatarKey = useMemoized(() => GlobalKey());

    void goToDrawerPage() {
      final renderBox = avatarKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;

        Navigator.of(context).push(
          AvatarTransitionRoute(
            page: const DrawerPage(), // Replace with your actual PageTwo
            startOffset: Offset(
              (position.dx + size.width / 2) / MediaQuery.of(context).size.width,
              (position.dy + size.height / 2) / MediaQuery.of(context).size.height,
            ),
            avatarSize: size,
          ),
        );
      }
    }
    return BaseScaffold(
      includeHorizontalPadding: true,
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
          child:Stack(

            children: [
              // YMargin(20),
              // Positioned(
              //   top: 10.h,
              //   left: 16.w,
              //   child: TweenAnimationBuilder(
              //   tween: Tween<Offset>(
              //     begin: Offset.zero,
              //     end: Offset.zero,
              //   ),
              //   duration: const Duration(milliseconds: 800),
              //   builder: (context, value, child) {
              //     return Transform.translate(
              //       offset: value,
              //       child: child,
              //     );
              //   },
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.of(context).push(
              //           PageRouteBuilder(
              //             transitionDuration: const Duration(milliseconds: 1000),
              //             pageBuilder: (_, animation, __) => DrawerPage()/*SecondPage(animation: animation)*/,
              //           )
              //       );
              //     },
              //     child: CircleAvatar(
              //       radius: 30,
              //       backgroundColor: Colors.transparent,
              //       child: SvgPicture.asset(
              //         'ic_avatar'.svg,
              //         width: 60,
              //         height: 60,
              //       ),
              //     ),
              //   ),
              // ), ),
              Positioned(
                left: MediaQuery.of(context).size.width * avatarOffset.dx,
                top: MediaQuery.of(context).size.height * avatarOffset.dy,
                child:    GestureDetector(
                onTap: (){
                  goToDrawerPage();

                }/*MaterialPageRoute(builder: (_) => DrawerPage())*/,/*locator<AppRouter>().navigate(customPageRoute(DrawerPage()))*/
                child:    Hero(
                  tag: "avatarHero",
                  child: CircleAvatar(
                    key: avatarKey,
                    radius: 30.r,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset('ic_avatar'.svg, width: 40.w),
                  ),
                ),

              ), ),
              Positioned(
                right: 16.w,
                top: 20.h,
                child:   Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: CustomColors.green
                ),
                child: Text("Earn ₦10k",style: CustomTextStyle.textStyleManrope.copyWith(
                    color:CustomColors.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    height: 21.78.toLineHeight(18.sp)),),
              ),),
              Positioned(

                  child: Column(
                    children: [
                      YMargin(120),
                Center(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("ic_gb".svg),
                          XMargin(5),
                          Text("GBP Balance",
                              style: CustomTextStyle.textStyleManrope.copyWith(
                                  color:CustomColors.coolGray,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 21.78.toLineHeight(18.sp))),
                        ],
                      ),
                      YMargin(8),
                      Text("GBP 67",style: CustomTextStyle.textStyleManrope.copyWith(
                          color:Colors.black,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                          height: 21.78.toLineHeight(18.sp))),
                      YMargin(8),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: CustomColors.coolGray100
                        ),

                        child: Text("Accounts",style: CustomTextStyle.textStyleManrope.copyWith(
                            color:Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            height: 21.78.toLineHeight(18.sp)),),
                      ),
                      YMargin(30.h),
                      SvgPicture.asset("ic_indicators".svg),

                    ],
                  ),
                ),
                YMargin(25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _transactionPoint("Send",Colors.black,"ic_arrow_top",CustomColors.whiteColor),
                    _transactionPoint("Convert",CustomColors.coolGray100,"ic_arrow_swap",Colors.black),
                    _transactionPoint("Add",CustomColors.coolGray100,"ic_plus",Colors.black),
                    _transactionPoint("",CustomColors.coolGray100,"ic_more_horiz",Colors.black),

                  ],
                ),
                YMargin(25),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),
                                  color: CustomColors.whiteColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Transactions",style: CustomTextStyle.textStyleManrope.copyWith(
                                          color:Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 21.78.toLineHeight(14.sp))),
                                      Icon(Icons.navigate_next)
                                    ],
                                  ),
                                  YMargin(10),
                                  _transactionItem(
                                      "ic_arrow_swap",
                                      Colors.black,
                                      CustomColors.coolGray100,
                                      Row(
                                        children: [
                                          Text("GBP",style: CustomTextStyle.textStyleManrope.copyWith(
                                              color:Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              height: 21.78.toLineHeight(18.sp))),
                                          XMargin(4),
                                          RotatedBox(
                                              quarterTurns: 1,
                                              child: SvgPicture.asset("ic_arrow_top".svg, color: Colors.black, height: 10.h,)),
                                          XMargin(4),
                                          Text("NGN",style: CustomTextStyle.textStyleManrope.copyWith(
                                              color:Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              height: 21.78.toLineHeight(18.sp))),
                                        ],
                                      ),
                                      "Converted", "Yesterday",
                                      "50 GBP","110,862 NGN"),
                                  YMargin(20),
                                  _transactionItem(
                                      "ic_arrow_top",
                                      Color(0XFFD6A400),
                                      Color(0XFFF5F18E),
                                      Text("John Doe",style: CustomTextStyle.textStyleManrope.copyWith(
                                          color:Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 21.78.toLineHeight(18.sp))),
                                      "Sent", "Yesterday",
                                      "10 GBP","1,718.8 KES"),
                                  YMargin(20),
                                  _transactionItem(
                                      "ic_arrow_top",
                                      Colors.black,
                                      CustomColors.coolGray100,
                                      Text("Cad Guy",style: CustomTextStyle.textStyleManrope.copyWith(
                                          color:Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 21.78.toLineHeight(18.sp))),

                                      "Sent", "May 3",
                                      "200 GBP","366 CAD"),
                                ],
                              ),
                            ),
                            YMargin(25),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),
                                  color: CustomColors.whiteColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Exchange rates",style: CustomTextStyle.textStyleManrope.copyWith(
                                          color:Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 21.78.toLineHeight(14.sp))),
                                      Icon(Icons.navigate_next)
                                    ],
                                  ),
                                  YMargin(10),
                                  _exchangeRate(
                                      "ic_gb",
                                      Text("1 GBP = 2,205.14 NGN",style: CustomTextStyle.textStyleManrope.copyWith(
                                          color:Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 21.78.toLineHeight(18.sp))),
                                      "GBP","NGN"),
                                  YMargin(20),
                                  _exchangeRate(
                                      "ic_cad_flag",
                                      Text("1 CAD = 1,112.20 NGN",style: CustomTextStyle.textStyleManrope.copyWith(
                                          color:Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 21.78.toLineHeight(18.sp))),
                                      "CAD","NGN"),
                                  YMargin(20),
                                  _exchangeRate(
                                      "ic_eur_flag",
                                      Text("1 EUR = 1,771.30 NGN",style: CustomTextStyle.textStyleManrope.copyWith(
                                          color:Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 21.78.toLineHeight(18.sp))),
                                      "EUR","NGN"),
                                ],
                              ),
                            ),
                            YMargin(25),
                          ],),
                      ),
                    ),


              ],)),



            ],

          ),
        );
      },
    );
  }
  Widget _transactionPoint(String dec, Color color, String iconPath, Color textColor){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: color
      ),
      child: Row(
        children: [
          XMargin(5.w),
          SvgPicture.asset(iconPath.svg),
          dec.isNotEmpty? Row(
            children: [
              XMargin(5.w),
              Text(dec,
                  style: CustomTextStyle.textStyleManrope.copyWith(
                      color:textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 21.78.toLineHeight(18.sp))),
            ],
          ): SizedBox.shrink(),

          XMargin(5.w),

        ],
      ),
    );
  }

  Widget _transactionItem(String prefixUrl,Color prefixColor, Color prefixContColor,  Widget transWidget, String transDes, String dateDay, String value, String valueDes){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: prefixContColor
        ),
        child: SvgPicture.asset(prefixUrl.svg, color: prefixColor,height: 20.h,),
      ),
        XMargin(8),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              transWidget,
              YMargin(4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transDes,style: CustomTextStyle.textStyleManrope.copyWith(
                      color:Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 21.78.toLineHeight(18.sp))),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 5,
                      width: 5,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.coolGray500
                      ),
                    ),
                  ),
                  Text(dateDay,style: CustomTextStyle.textStyleManrope.copyWith(
                      color:Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 21.78.toLineHeight(18.sp))),


              ],)
          ],),
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value,style: CustomTextStyle.textStyleManrope.copyWith(
                color:Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 21.78.toLineHeight(18.sp))),
            YMargin(4),
            Text(valueDes,style: CustomTextStyle.textStyleManrope.copyWith(
                color:Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 21.78.toLineHeight(18.sp))),

          ],
        )
    ],);
  }


  Widget _exchangeRate(String prefixUrl , Widget transWidget, String currency1, String currency2){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child: SvgPicture.asset(prefixUrl.svg,height: 40.h,),
        ),
      /*  Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),

          ),
          child: SvgPicture.asset(prefixUrl.svg,height: 20.h,),
        ),*/
        XMargin(8),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              transWidget,
              YMargin(4),
              Row(
                children: [
                  Text(currency1,style: CustomTextStyle.textStyleManrope.copyWith(
                      color:Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 21.78.toLineHeight(18.sp))),
                  XMargin(4),
                  RotatedBox(
                      quarterTurns: 1,
                      child: SvgPicture.asset("ic_arrow_top".svg, color: CustomColors.coolGray400,)),
                  XMargin(4),
                  Text(currency2,style: CustomTextStyle.textStyleManrope.copyWith(
                      color:Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 21.78.toLineHeight(18.sp))),
                ],
              ),
            ],),
        ),

      ],);
  }

  Widget _flightShuttleBuilder(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
      ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final curvedAnimation = Curves.easeInOut.transform(animation.value);
        final double dx = lerpDouble(20, MediaQuery.of(flightContext).size.width / 2 - 50, curvedAnimation)!;
        final double dy = lerpDouble(40, MediaQuery.of(flightContext).size.height / 2 - 50, curvedAnimation)!;

        return Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.scale(
            scale: lerpDouble(1, 2, curvedAnimation),
            child: child,
          ),
        );
      },
      child: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage('assets/avatar.jpg'),
      ),
    );
  }

}
