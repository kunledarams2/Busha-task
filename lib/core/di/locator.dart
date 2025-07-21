
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_router.dart';





GetIt locator = GetIt.instance;

Future<void> setupLocator() async {

  //Register App Router
  final appRouter = AppRouter();
  locator.registerSingleton(appRouter);


}
