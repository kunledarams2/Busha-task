import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'app.dart';
import 'core/di/locator.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  Animate.restartOnHotReload = true;

  await Future.delayed(Duration(seconds: 5));
  runApp(const ProviderScope(child:MyApp()));
}




