import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/global/person_manager.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/person/person_detail.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/model/person/person_movie_cast.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/service/app_service.dart';

class PersonDetailController extends GetxController {
  // Variable
  PersonInfo? info;

  PersonDetail? personDetail;

  RxBool isLoading = true.obs;

  RxDouble appBarOpacity = 0.0.obs;
  final ScrollController detailController = ScrollController();

  // Movie Casting List
  List<PersonMovieCast> movieCreditsList = <PersonMovieCast>[];

  // Page LifeCycle
  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;

    if (!arguments.containsKey('personInfo')) {
      // display error state on UI
      isLoading.value = false;
      return;
    }

    info = arguments['personInfo'] as PersonInfo;

    if (info!.id == null) {
      // display error state on UI
      isLoading.value = false;
      return;
    }
    detailController.addListener(onPageScrolling);

    _getPersonDetail(info!.id!);
  }

  @override
  void onClose() {
    detailController.removeListener(onPageScrolling);
    super.onClose();
  }

  // Listener
  void onPageScrolling() {
    if (detailController.offset == 0.0) {
      appBarOpacity.value = 0.0;
      return;
    }

    appBarOpacity.value = ((detailController.offset + kToolbarHeight) /
            (AppService().appScreenSize.height * 0.6))
        .clamp(0.0, 1.0);
  }

  // Method

  // Get Person Detail Info
  Future<void> _getPersonDetail(int personId) async {
    final PersonDetail? detail =
        await PersonManager().getRemotePersonDetail(personId);

    if (detail == null) {
      isLoading.value = false;
      return;
    }

    personDetail = detail;

    await _getPersonMovieCredit(personId);

    isLoading.value = false;
    update(['person_detail_view'].toList());
  }

  Future<void> _getPersonMovieCredit(personId) async {
    final creditList = await PersonManager().getRemotePersonMovieCast(personId);
    movieCreditsList.assignAll(creditList);
  }

  /// Navigate to Movie detail
  void goToMovieDetail(MovieInfo info) => Routes.toMovieDetail(info);
}
