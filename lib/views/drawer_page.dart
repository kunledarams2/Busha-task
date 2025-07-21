import 'package:auto_route/annotations.dart';
import 'package:busha_task/routes/__export__.dart';
import 'package:busha_task/shared/utils/custom_designs/custom_margins.dart';
import 'package:busha_task/shared/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/di/locator.dart';
import '../core/theme/customText.dart';
import '../core/theme/custom_colors.dart';
import '../shared/utils/custom_designs/base_scaffold.dart';

@RoutePage()
class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});


  @override
  _DrawerPageState createState() => _DrawerPageState();
  }


class _DrawerPageState extends State<DrawerPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<Offset> _avatarSlide;
  late Animation<double> _fadeUserInfo;
  late Animation<double> _avatarScale;
  late Animation<Offset> _logoutSlide;
  late Animation<double> _avatarScaleIn;
  late Animation<double> _avatarScaleOut;

  late Animation<Offset> _slideUserInfo;

  late List<Animation<Offset>> _itemAnimations = [];
  late List<Animation<double>> _itemFadeAnimations = [];
  bool isExiting = false;

  @override
  void initState() {
    super.initState();


    // _controller = AnimationController(
    //   duration: Duration(milliseconds: 3000),
    //   vsync: this,
    // );
    // _animation = Tween<Offset>(
    //   begin: Offset(-1.0, -1.0),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeOut,
    // ));


    _controller = AnimationController(
      duration: const Duration(milliseconds: 4500),
      vsync: this,
    );

    // Slide from top to center
    _avatarSlide = Tween<Offset>(
      begin: const Offset(-0.6, -1), // Off-screen top
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

// Scale from small to full
    _avatarScale = Tween<double>(
      begin: 0.9, // start small
      end: 1.0,   // end at full size
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    // Avatar Slide from top left
    // _avatarAnimation = Tween<Offset>(
    //   begin: const Offset(-1.0, -1.0),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3, curve: Curves.easeOut)));

    // Slide from top to center
    // _avatarSlide = Tween<Offset>(
    //   begin: const Offset(-1, 0), // Off-screen top
    //   end: Offset.zero,
    // ).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    //   ),
    // );

//     _avatarScale = Tween<double>(
//       begin: 0.6,
//       end: 1.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
//       ),
//     );
//
//     _avatarSlide = Tween<Offset>(
//       begin: const Offset(0, -1), // Off-screen top
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
//       ),
//     );
//
// // Entry scale: small -> full
//     _avatarScaleIn = Tween<double>(
//       begin: 0.6,
//       end: 1.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.0, 0.4, curve: Curves.easeOut),
//       ),
//     );
//
// // Exit scale: full -> small
//     _avatarScaleOut = Tween<double>(
//       begin: 1.0,
//       end: 0.6,
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(0.6, 1.0, curve: Curves.easeIn),
//       ),
//     );



    // Fade + Slide for user info
    _fadeUserInfo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3)),
    );
    _slideUserInfo = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );

    // Fade + Slide for list items (staggered)
    const itemCount = 6;
    for (int i = 0; i < itemCount; i++) {
      double start = 0.3 + (i * 0.1);
      double end = start + 0.2;

      _itemAnimations.add(
        Tween<Offset>(
          begin: const Offset(-0.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _controller, curve: Interval(start, end, curve: Curves.easeOut)),
        ),
      );
      _itemFadeAnimations.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: Interval(start, end)),
        ),
      );
    }

    // Slide logout section
    _logoutSlide = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.7, curve: Curves.easeOut)));

    // List items slide in
    _itemAnimations = List.generate(6, (index) {
      final start = 0.3 + (index * 0.07);
      return Tween<Offset>(
        begin: Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, start + 0.2, curve: Curves.easeOut),
      ));
    });



    _controller.forward();
  }

  void _onExit() {
    setState(() => isExiting = true);
    _controller.reverse().then((_) {
      Navigator.of(context).pop();
    });
  }


  bool _showAvatar = false;

  Animation<double>? _routeAnimation;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      _routeAnimation = route.animation;
      _routeAnimation?.addStatusListener(_handleAnimationStatus);
    }
  }

  @override
  void dispose() {
    _routeAnimation?.removeStatusListener(_handleAnimationStatus); // ✅ safe cleanup
    super.dispose();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() => _showAvatar = true);
    } else if (status == AnimationStatus.reverse || status == AnimationStatus.dismissed) {
      setState(() => _showAvatar = false);
    }
  }

  // @override
  // void dispose() {
  //   final route = ModalRoute.of(context);
  //   if (route is PageRoute) {
  //     route.animation?.removeStatusListener(_handleAnimationStatus);
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      includeHorizontalPadding: true,
      backgroundColor:CustomColors.backgroundColor,
      childHasCustomHeader: false,

      safeTop: true,
      safeBottom: true,
      onWillPop: () {},

      builder: (size) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor:CustomColors.backgroundColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: CustomColors.whiteColor ,
            systemNavigationBarIconBrightness: Brightness.dark,

          ),
          child:  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            FadeTransition(
              opacity: _fadeUserInfo ,
              child: SlideTransition(
                position: _slideUserInfo,
                child: GestureDetector(
                    onTap: () async {
                      _controller.reverse().then((_) {
                        Navigator.of(context).pop();
                      });

                     }/*locator<AppRouter>().navigate(HomeRoute())*/,
                    child: SvgPicture.asset("ic_close".svg,height: 40.h,)),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column( mainAxisAlignment: MainAxisAlignment.center,children: [
                        YMargin(_showAvatar?45:120),
                        _showAvatar?ScaleTransition(
                          scale: _avatarScale,
                          child: Center(
                            child: Hero(
                              tag: "avatarHero",
                              child: SvgPicture.asset(
                                'ic_avatar'.svg,
                                width: 80.w,
                                height: 80.h,
                              ),
                            ),
                          ),
                        ):SizedBox.shrink(),

                        // SlideTransition(
                        //   position: _avatarSlide,
                        //   child: ScaleTransition(
                        //     scale: _avatarScale,
                        //     child: ,
                        //   ),
                        // ),
                        //
                        //
                        //
                        // YMargin(10),
                        FadeTransition(opacity: _fadeUserInfo,
                        child:  SlideTransition(
                          position: _slideUserInfo,
                          child: Text("John Doe",style: CustomTextStyle.textStyleManrope.copyWith(
                              color:Colors.black,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              height: 21.78.toLineHeight(18.sp))),
                        ) ,),
                      ],),
                    ),
                    // SlideTransition(position: _itemAnimations)
                    FadeTransition(
                      opacity: _fadeUserInfo,
                      child: SlideTransition(
                        position: _slideUserInfo,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          YMargin(20),
                          _itemWrapper("Get help", "Contact support and resolve your issues.",8.0,0),
                          _itemWrapper("Account information", "Update your personal details or securely close your account.", 18,0),
                          _itemWrapper("Privacy and security", "Manage your password, 2-step verification, and biometrics.",18,0),
                          _itemWrapper("Preferences", "Customize notifications and appearance settings to tailor your app experience.",18,0),
                          _itemWrapper("Connected accounts", "Manage your mobile money numbers and payment emails.",18,0),
                          _itemWrapper("About us", "Access FAQs, terms and conditions, our blog, and contact options.",18,0),
                          YMargin(12.h),
                        ],),
                      ),
                    ),


                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(20),
                          color: CustomColors.whiteColor),
                      child: Row( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text("Log out", style: CustomTextStyle.textStyleManrope.copyWith(
                                color:Colors.red,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                height: 21.78.toLineHeight(24.sp))),
                          ),



                          Padding(
                            padding:  EdgeInsets.symmetric(vertical:0.h),
                            child: Icon(Icons.navigate_next, size: 25.h, color: Colors.red,),
                          )

                        ],),
                    ),
                    YMargin(12.h),
                    Center(
                      child: Text("Version 0.4.3 (3)",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.textStyleManrope.copyWith(
                          color:Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w200,
                          height: 21.78.toLineHeight(24.sp))),
                    ),
                    YMargin(30.h),
                  ],),
              ),
            ),


          ],),
        );
      },
    );
  }

  Widget _itemWrapper(String title, String dec, double iconVerticalPadding, int index){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YMargin(12.h),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(20),
              color: CustomColors.whiteColor),
          child: Row( crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: CustomTextStyle.textStyleManrope.copyWith(
                        color:Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        height: 21.78.toLineHeight(18.sp))),
                    YMargin(5),
                    Text(dec,style: CustomTextStyle.textStyleManrope.copyWith(
                        color:Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,

                        height: 21.78.toLineHeight(14.sp))),

                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(vertical:iconVerticalPadding.h),
                child: Icon(Icons.navigate_next, size: 25.h, color: Colors.black54,),
              )

            ],),
        ),
      ],
    )/*SlideTransition(
      position: _itemAnimations[index],
      child: ,
    )*/;
  }


}
