import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/util/color.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Hero(
            tag: 'app_logo',
            child: SvgPicture.asset(
              'assets/svg/tmdb_app_256.svg',
              width: 48.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          // Now playing PageView
          GetBuilder(
            id: 'now_playing',
            init: controller,
            builder: (_) {
              return const SizedBox();
            },
          ),

          // For you
        ],
      )),
    );
  }
}
