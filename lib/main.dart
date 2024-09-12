import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/api/common.dart';
import 'package:wizlah_assignment/api/http_util.dart';
import 'package:wizlah_assignment/api/movie.dart';
import 'package:wizlah_assignment/global/movie_manager.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/service/local_storage.dart';
import 'package:wizlah_assignment/util/config.dart';

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await LocalStorageService().init();
    await MovieManager().init();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
