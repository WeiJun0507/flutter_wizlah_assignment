import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/pages/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wizlah Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: Routes.getPages,
      home: const SplashScreen(),
    );
  }
}
