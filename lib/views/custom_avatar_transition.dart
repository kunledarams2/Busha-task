import 'package:busha_task/shared/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarTransitionRoute extends PageRouteBuilder {
  final Widget page;
  final Offset startOffset;
  final Size avatarSize;

  AvatarTransitionRoute({
    required this.page,
    required this.startOffset,
    this.avatarSize = const Size(60, 60),
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 2500),
    reverseTransitionDuration: Duration(milliseconds: 2500),
    opaque: false,
    barrierColor: null,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      );

      final slideTween = Tween<Offset>(
        begin: startOffset,
        end: Offset(0.55.w, 0.22.h),
      ).animate(curved);

      final scaleTween = Tween<double>(
        begin: 1.0,
        end: 1.5,
      ).animate(curved);

      return AnimatedBuilder(
        animation: curved,
        builder: (context, _) {
          final status = curved.status;
          final isAnimating = status == AnimationStatus.forward || status == AnimationStatus.reverse;

          final screen = MediaQuery.of(context).size;
          final dx = slideTween.value.dx * screen.width;
          final dy = slideTween.value.dy * screen.height;

          return Stack(
            children: [
              FadeTransition(opacity: curved, child: child),
              if (isAnimating)
                Positioned(
                  left: dx - (avatarSize.width * scaleTween.value / 2),
                  top: dy - (avatarSize.height * scaleTween.value / 2),
                  child: Transform.scale(
                    scale: scaleTween.value,
                    child: CircleAvatar(
                      radius: avatarSize.width / 2,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        'ic_avatar'.svg,
                        width: 40.w,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    },
  );
}

