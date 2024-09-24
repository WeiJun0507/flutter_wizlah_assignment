import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/person/person_movie_cast.dart';
import 'package:wizlah_assignment/pages/components/empty_state_view.dart';
import 'package:wizlah_assignment/pages/person/components/movie_credit_item.dart';
import 'package:wizlah_assignment/pages/person/components/skeleton_person_detail_casting.dart';
import 'package:wizlah_assignment/pages/person/person_detail_controller.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class PersonDetailView extends StatelessWidget {
  final String tag;
  late final PersonDetailController controller;

  PersonDetailView({
    super.key,
    required this.tag,
  }) {
    controller = Get.find<PersonDetailController>(tag: tag.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'person_detail_view',
      init: controller,
      builder: (_) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColor.primaryColor,
          body: NestedScrollView(
            controller: controller.detailController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: AppColor.primaryColor,
                  leading: Obx(
                    () => Opacity(
                      opacity: controller.appBarOpacity.value,
                      child: InkWell(
                        onTap: Get.back,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColor.whitePrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  centerTitle: true,
                  title: Obx(
                    () => Opacity(
                      opacity: controller.appBarOpacity.value,
                      child: Column(
                        children: [
                          StText.normal(
                            controller.info?.name ?? 'Person Detail',
                          ),
                          StText.small(
                            '${controller.info?.genderString} · ${controller.personDetail?.birthday ?? "-"}',
                            style: StandardTextStyle.small.copyWith(
                              color: AppColor.whiteSecondaryColor,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  expandedHeight: AppService().appScreenSize.height * 0.6,
                  pinned: true,
                  flexibleSpace: Obx(
                    () => Opacity(
                      opacity: 1.0 - controller.appBarOpacity.value,
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: controller.info?.id.toString() ?? '',
                            child: ExtendedImage.network(
                              Images.getUrl(
                                controller.info?.profilePath,
                                size: Images.profileHighest,
                              ),
                              width: AppService().appScreenSize.width,
                              height: AppService().appScreenSize.height * 0.6,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // bottom gradient
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            height: AppService().appScreenSize.height * 0.15,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColor.primaryColor,
                                    AppColor.primaryColor.withOpacity(0.8),
                                    AppColor.secondaryColor,
                                    AppColor.blackAccentColor,
                                    Colors.transparent,
                                  ],
                                  stops: const [
                                    0.1,
                                    0.4,
                                    0.6,
                                    0.8,
                                    1.0,
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SysSize.paddingBig,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  StText.big(controller.info?.name),
                                  const SizedBox(height: SysSize.paddingMedium),
                                  StText.small(
                                    '${controller.info?.genderString} · ${controller.personDetail?.birthday ?? "-"} · ${controller.personDetail?.placeOfBirth ?? ""}',
                                    style: StandardTextStyle.small.copyWith(
                                      color: AppColor.whiteSecondaryColor,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: AppService().appViewPadding.top,
                            right: SysSize.paddingBig,
                            child: InkWell(
                              onTap: Get.back,
                              child: Container(
                                padding: const EdgeInsets.all(
                                  SysSize.paddingSmall,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.whiteSecondaryColor,
                                  borderRadius: BorderRadius.circular(
                                    SysSize.paddingMedium,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: SysSize.huge,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SysSize.paddingBig,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: SysSize.paddingHuge),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const SkeletonPersonDetailCasting();
                      }

                      if (controller.personDetail == null) {
                        return Center(
                          child: Column(
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/svg/state/empty_state.svg',
                                height: 100.0,
                                width: 100.0,
                              ),
                              const SizedBox(height: SysSize.paddingBig),
                              const StText.normal(
                                'Something wrong. Please try again.',
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildBiography(context),
                          _buildMovieCreditList(context),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBiography(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const StText.big('Biography'),
        const SizedBox(height: SysSize.paddingMedium),
        if (controller.personDetail?.biography?.isEmpty ?? true)
          StText.small(
            'This person do not have any biography.',
            style: StandardTextStyle.small.copyWith(
              color: AppColor.whitePrimaryColor.withOpacity(0.8),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(SysSize.paddingSmall),
            decoration: BoxDecoration(
              color: AppColor.whiteBorderColor,
              borderRadius: BorderRadius.circular(SysSize.paddingMedium),
              border: Border.all(color: AppColor.whiteAccentColor),
            ),
            child: StText.small(
              controller.personDetail?.biography,
              style: StandardTextStyle.small.copyWith(
                color: AppColor.whitePrimaryColor.withOpacity(0.8),
              ),
            ),
          ),
        const SizedBox(height: SysSize.paddingHuge),
      ],
    );
  }

  Widget _buildMovieCreditList(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const StText.big('Movie Cast'),
          const SizedBox(height: SysSize.paddingMedium),
          if (controller.movieCreditsList.isEmpty)
            EmptyStateView(onRetry: controller.onCreditRetry)
          else
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.movieCreditsList.length,
                itemBuilder: (BuildContext context, int index) {
                  final PersonMovieCast cast =
                      controller.movieCreditsList[index];
                  return MovieCreditItem(
                    cast: cast,
                    onDetailTap: () => controller.goToMovieDetail(
                      MovieInfo.fromJson(cast.toJson()),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: SysSize.paddingHuge),
        ],
      ),
    );
  }
}
