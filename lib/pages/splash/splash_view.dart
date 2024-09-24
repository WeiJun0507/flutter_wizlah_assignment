import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/global/movie_manager.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/service/local_storage_service.dart';
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
      () => Get.offAndToNamed(RouteName.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (AppService().appScreenSize == Size.zero) {
      AppService().appScreenSize = MediaQuery.sizeOf(context);
    }

    if (AppService().appViewPadding == EdgeInsets.zero) {
      AppService().appViewPadding = MediaQuery.viewPaddingOf(context);
    }

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Hero(
          tag: HomeController.appLogo,
          child: SvgPicture.asset(
            'assets/svg/tmdb_app_256.svg',
            width: 128,
          ),
        ),
      ),
    );
  }
}
