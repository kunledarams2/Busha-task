

import 'package:flutter/cupertino.dart';

PageRouteBuilder customPageRoute(Widget page) {
  return  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 3000),
    pageBuilder: (_, anim, secAnim) => page,
    transitionsBuilder: (_, anim, secAnim, child) {
      final slide = Tween<Offset>(begin: Offset(-0.5, 0), end: Offset.zero)
          .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut));
      final fade = Tween<double>(begin: 0, end: 1)
          .animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut));
      return SlideTransition(position: slide, child: FadeTransition(opacity: fade, child: child));
    },
  );

    /* PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 2000),
    reverseTransitionDuration: Duration(milliseconds: 2000),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide from right and fade in
      final slideTween = Tween<Offset>(begin: Offset(-0.5,0), end: Offset.zero);
      final fadeTween = Tween<double>(begin: 0, end: 1.0);

      return SlideTransition(
        position: animation.drive(CurveTween(curve: Curves.easeIn)).drive(slideTween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        ),
      );
    },
  )*/;
}