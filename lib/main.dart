import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:midilink/app.dart';

void main() async{  /// Add Widgets Binding
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  /// Init Local Storage
  await GetStorage.init();

  // Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const App());
}