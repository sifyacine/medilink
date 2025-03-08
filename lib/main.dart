import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:midilink/app.dart';

void main() async{  /// Add Widgets Binding


  /// Init Local Storage
  await GetStorage.init();

  runApp(const App());
}