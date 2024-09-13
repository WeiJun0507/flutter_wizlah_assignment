import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/global/movie_manager.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/service/local_storage.dart';
import 'package:wizlah_assignment/util/color.dart';

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
    MovieManager().init();

    Future.delayed(
      const Duration(seconds: 2),
      () => Get.toNamed(RouteName.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Hero(
          tag: 'app_logo',
          child: SvgPicture.asset(
            'assets/svg/tmdb_app_256.svg',
            width: 128,
          ),
        ),
      ),
    );
  }
}
