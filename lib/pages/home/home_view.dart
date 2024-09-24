import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/movie/movie_view.dart';
import 'package:wizlah_assignment/pages/home/person/person_view.dart';
import 'package:wizlah_assignment/pages/home/search/search_view.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'home',
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColor.primaryColor,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.homePageController,
            children: const <Widget>[
              MovieView(),
              SearchView(),
              PersonView(),
            ],
          ),
          bottomNavigationBar: GNav(
            selectedIndex: controller.bottomNavIdx,
            onTabChange: controller.onBottomNavTabChanged,
            activeColor: AppColor.whitePrimaryColor,
            curve: Curves.easeOut,
            gap: SysSize.paddingMedium,
            padding: const EdgeInsets.symmetric(
              vertical: SysSize.paddingMedium,
              horizontal: SysSize.paddingBig,
            ),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            tabMargin: const EdgeInsets.all(SysSize.paddingBig),
            tabs: [
              GButton(
                icon: Icons.home,
                iconColor: AppColor.whiteAccentColor,
                text: 'Home',
                backgroundColor: AppColor.themeColor,
              ),
              GButton(
                icon: Icons.search,
                iconColor: AppColor.whiteAccentColor,
                text: 'Search',
                backgroundColor: AppColor.themeColor,
              ),
              GButton(
                icon: Icons.person_outline,
                iconColor: AppColor.whiteAccentColor,
                text: 'Person',
                backgroundColor: AppColor.themeColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
