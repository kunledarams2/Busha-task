

import 'package:auto_route/auto_route.dart';
import '__export__.dart';
// import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: Tabhost.page,
      path: Routes.tabHostRoute,
    ),

    AutoRoute(
      page: HomeRoute.page,
      path: Routes.homePageRoute,
    ),

    AutoRoute(
      page: DrawerRoute.page,
      path: Routes.homePageRoute,
    ),

  ];
}
