import 'package:get/get.dart';
import 'package:wizlah_assignment/main.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/home_view.dart';

class RouteName {
  static const String home = '/home';
}

class Routes {
  static final List<GetPage> getPages = [
    GetPage(
      name: RouteName.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
  ];
}
