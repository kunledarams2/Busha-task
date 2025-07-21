// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:busha_task/views/drawer_page.dart' as _i5;
import 'package:busha_task/views/home_page.dart' as _i3;
import 'package:busha_task/views/recipients_page.dart' as _i4;
import 'package:busha_task/views/tabNavigationBar/tabHost.dart' as _i2;
import 'package:busha_task/views/transactions_page.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    TransactionsRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.TransactionsPage(),
      );
    },
    Tabhost.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Tabhost(),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.HomePage(key: args.key),
      );
    },
    RecipientsRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RecipientsPage(),
      );
    },
    DrawerRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DrawerPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.TransactionsPage]
class TransactionsRoute extends _i6.PageRouteInfo<void> {
  const TransactionsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TransactionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionsRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Tabhost]
class Tabhost extends _i6.PageRouteInfo<void> {
  const Tabhost({List<_i6.PageRouteInfo>? children})
      : super(
          Tabhost.name,
          initialChildren: children,
        );

  static const String name = 'Tabhost';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i6.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i8.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<HomeRouteArgs> page =
      _i6.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.RecipientsPage]
class RecipientsRoute extends _i6.PageRouteInfo<void> {
  const RecipientsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RecipientsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecipientsRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DrawerPage]
class DrawerRoute extends _i6.PageRouteInfo<void> {
  const DrawerRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DrawerRoute.name,
          initialChildren: children,
        );

  static const String name = 'DrawerRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
