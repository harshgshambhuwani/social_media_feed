

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/main_Binding.dart';
import 'screens/dashboard.dart';
import 'screens/splash.dart';

class Root extends StatelessWidget {
  const Root({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black87
      ),
      home:  Splash(),
      initialBinding: MainBinding(),
    );
  }
}
