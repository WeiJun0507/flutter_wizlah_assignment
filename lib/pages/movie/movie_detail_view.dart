import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/api/util/images.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/movie/movie_review.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/pages/components/empty_state_view.dart';
import 'package:wizlah_assignment/pages/home/movie/components/movie_cover.dart';
import 'package:wizlah_assignment/pages/home/movie/components/movie_rating.dart';
import 'package:wizlah_assignment/pages/movie/components/movie_casting_item.dart';
import 'package:wizlah_assignment/pages/movie/components/movie_review_item.dart';
import 'package:wizlah_assignment/pages/movie/components/skeleton_movie_detail_casting.dart';
import 'package:wizlah_assignment/pages/movie/movie_detail_controller.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieDetailView extends StatelessWidget {
  final String tag;
  late final MovieDetailController controller;

  MovieDetailView({
    super.key,
    required this.tag,
  }) {
    controller = Get.find<MovieDetailController>(tag: tag);
  }

  Widget imageLoadStateCallback(ExtendedImageState imageState) {
    switch (imageState.extendedImageLoadState) {
      case LoadState.failed:
        return Image.asset(
          'assets/image/tmdb_loading_placeholder.png',
          height: 200,
          width: AppService().appScreenSize.width,
          fit: BoxFit.cover,
        );
      case LoadState.completed:
        return imageState.completedWidget;
      default:
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.themeColor,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.primaryColor,
      body: GetBuilder<MovieDetailController>(
        id: MovieDetailController.movieDetailView,
        tag: tag,
        builder: (_) {
          if (controller.info == null) {
            return Align(
              alignment: Alignment.center,
              child: EmptyStateView(title: 'movie detail', onRetry: Get.back),
            );
          }

          return NestedScrollView(
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
                        onTap: controller.appBarOpacity.value > 0.0
                            ? Get.back
                            : null,
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
                      child: StText.normal(
                        controller.info!.title ?? 'Movie Detail',
                      ),
                    ),
                  ),
                  expandedHeight: AppService().appScreenSize.height * 0.2,
                  pinned: true,
                  flexibleSpace: Obx(
                    () => Opacity(
                      opacity: 1.0 - controller.appBarOpacity.value,
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: controller.info!.id.toString(),
                            child: (controller.info!.backdropPath?.isEmpty ??
                                    true)
                                ? Image.asset(
                                    'assets/image/tmdb_loading_placeholder.png',
                                    height: 200,
                                    width: AppService().appScreenSize.width,
                                    fit: BoxFit.cover,
                                  )
                                : ExtendedImage.network(
                                    Images.getUrl(
                                      controller.info?.backdropPath,
                                      size: Images.backdropHighest,
                                    ),
                                    width: AppService().appScreenSize.width,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    loadStateChanged: imageLoadStateCallback,
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
                                  colors: <Color>[
                                    AppColor.primaryColor,
                                    AppColor.primaryColor.withOpacity(0.8),
                                    AppColor.secondaryColor,
                                    AppColor.blackAccentColor,
                                    Colors.transparent,
                                  ],
                                  stops: const <double>[
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
                            top: AppService().appViewPadding.top +
                                (kToolbarHeight / 4),
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
                    Row(
                      children: [
                        Expanded(child: MovieRating(info: controller.info!)),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          padding: const EdgeInsets.all(SysSize.paddingSmall),
                          decoration: BoxDecoration(
                            color: AppColor.themeColor,
                            borderRadius:
                                BorderRadius.circular(SysSize.paddingSmall),
                          ),
                          child: StText.small(
                            'IMDB: ${controller.movieDetail?.imdbId ?? '-'}',
                            style: StandardTextStyle.small.copyWith(
                              color: AppColor.whitePrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SysSize.paddingMedium),
                    StText.big(
                      controller.movieDetail?.title ?? controller.info?.title,
                    ),
                    const SizedBox(height: SysSize.paddingMedium),
                    StText.small(
                      controller.movieDetail?.movieDetailSubtitle,
                      style: StandardTextStyle.small.copyWith(
                        color: AppColor.whiteSecondaryColor,
                      ),
                    ),

                    // Movie Overview
                    const SizedBox(height: SysSize.paddingHuge),
                    StText.small(
                      controller.info!.overview,
                      style: StandardTextStyle.small.copyWith(
                        color: AppColor.whitePrimaryColor.withOpacity(0.8),
                      ),
                    ),

                    // Genre Listing
                    if (controller.info!.genreTitle.isNotEmpty)
                      const SizedBox(height: SysSize.paddingBig),
                    if (controller.info!.genreTitle.isNotEmpty)
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          if (controller.info!.originalLanguage?.isNotEmpty ??
                              false)
                            Container(
                              margin: const EdgeInsets.only(
                                right: SysSize.paddingMedium,
                                bottom: SysSize.paddingMedium,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: SysSize.paddingSmall,
                                horizontal: SysSize.paddingMedium,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.whitePrimaryColor,
                                borderRadius: BorderRadius.circular(
                                  SysSize.paddingMedium,
                                ),
                              ),
                              child: StText.small(
                                controller.info!.originalLanguage!
                                    .toUpperCase(),
                                style: StandardTextStyle.small.copyWith(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                          ...List<Widget>.generate(
                            controller.info!.genreTitle.length,
                            (int index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                  right: SysSize.paddingMedium,
                                  bottom: SysSize.paddingMedium,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: SysSize.paddingSmall,
                                  horizontal: SysSize.paddingMedium,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.whiteAccentColor,
                                  borderRadius: BorderRadius.circular(
                                    SysSize.paddingMedium,
                                  ),
                                ),
                                child: StText.small(
                                  controller.info!.genreTitle[index],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                    Obx(() {
                      if (controller.isLoading.value) {
                        return const SkeletonMovieDetailCasting();
                      }

                      if (controller.movieDetail == null) {
                        // display error state
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
                        children: <Widget>[
                          _buildActorView(context),
                          _buildReviewList(context),
                          _buildRecommendationMovieView(context),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActorView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: SysSize.paddingHuge),
      height: 160.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const StText.big('Top Casts'),
          const SizedBox(height: SysSize.paddingBig),
          if (controller.movieCastingList.isEmpty)
            EmptyStateView(title: 'casting', onRetry: controller.onCastingRetry)
          else
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.movieCastingList.length,
                itemBuilder: (BuildContext context, int index) {
                  final PersonInfo info = controller.movieCastingList[index];
                  return MovieCastingItem(
                    info: info,
                    onDetailTap: () => controller.goToPersonDetail(info),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: SysSize.paddingHuge),
      height: AppService().appScreenSize.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const StText.big('Reviews'),
          const SizedBox(height: SysSize.paddingBig),
          if (controller.movieReviewList.isEmpty)
            Expanded(
              child: EmptyStateView(
                title: 'review',
                onRetry: controller.onReviewRetry,
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.movieReviewList.length,
                itemBuilder: (BuildContext context, int index) {
                  final MovieReview info = controller.movieReviewList[index];
                  return MovieReviewItem(info: info);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecommendationMovieView(context) {
    return Container(
      margin: EdgeInsets.only(
        top: SysSize.paddingHuge,
        bottom: AppService().appViewPadding.bottom,
      ),
      padding: const EdgeInsets.only(bottom: SysSize.paddingMedium),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const StText.big('Recommend for you'),
          const SizedBox(height: SysSize.paddingBig),
          if (controller.recommendationMovieList.isEmpty)
            Expanded(
              child: EmptyStateView(
                title: 'recommend movie',
                onRetry: controller.onRecommendRetry,
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.recommendationMovieList.length,
                itemBuilder: (BuildContext context, int index) {
                  final MovieInfo info =
                      controller.recommendationMovieList[index];
                  return MovieCover(
                    info: info,
                    onDetailTap: () => controller.onRecommendMovieTap(info),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
