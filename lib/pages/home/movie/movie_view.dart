import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/global/movie_manager.dart';
import 'package:wizlah_assignment/model/enum/home/common_enum.dart';
import 'package:wizlah_assignment/model/enum/home/home_key.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/pages/components/empty_state_view.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/movie/components/movie_cover.dart';
import 'package:wizlah_assignment/pages/home/movie/components/movie_listing_item.dart';
import 'package:wizlah_assignment/pages/home/movie/components/skeleton_movie_cover.dart';
import 'package:wizlah_assignment/service/app_service.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key});

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
            tag: HomeController.appLogo,
            child: SvgPicture.asset(
              'assets/svg/tmdb_app_256.svg',
              width: 48.0,
            ),
          ),
        ),
      ),
      body: GetBuilder(
        id: HomeController.movieMainView,
        init: Get.find<HomeController>(),
        builder: (HomeController controller) {
          if (controller.state == HomeLoadingState.isLoading) {
            return Center(
              key: const ValueKey(HomeKey.movieListingLoadingProgress),
              child: CircularProgressIndicator(
                color: AppColor.themeColor,
              ),
            );
          }

          return SingleChildScrollView(
            key: const ValueKey(HomeKey.movieListingScrollKey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Now playing PageView
                SizedBox(
                  height: AppService().appScreenSize.height * 0.6,
                  child: GetBuilder<HomeController>(
                    id: HomeController.nowPlaying,
                    builder: (HomeController controller) {
                      if (controller.nowPlayingMovieList.isEmpty) {
                        return EmptyStateView(
                          title: 'now playing movies',
                          onRetry: () {
                            MovieManager().getRemoteGenre();
                            controller.initMovieListAsync();
                          },
                        );
                      }

                      return PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.nowPlayingMovieList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MovieListingItem(
                            info: controller.nowPlayingMovieList[index],
                            onDetailTap: () => controller.goToMovieDetail(
                              controller.nowPlayingMovieList[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // For you
                _buildForYou(context, controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildForYou(BuildContext context, HomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SysSize.big,
        horizontal: SysSize.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StText.big('For you'),

          // Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SysSize.paddingBig),
            child: TabBar(
              controller: controller.forYouTabController,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.circular(SysSize.big),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(
                vertical: SysSize.paddingSmall,
              ),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              onTap: controller.onForYouTabChanged,
              tabs: const <Tab>[
                Tab(child: StText.normal('Most Watched')),
                Tab(child: StText.normal('Now Trending')),
                Tab(child: StText.normal('Upcoming Soon')),
              ],
            ),
          ),

          Obx(() {
            return AnimatedSwitcher(
              switchInCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: controller.isLoading.value
                  ? const SkeletonMovieCover()
                  : GetBuilder<HomeController>(
                      id: HomeController.forYou,
                      builder: (HomeController controller) {
                        List<MovieInfo> movieList = [];
                        switch (controller.currentTabIdx) {
                          case 1:
                            movieList = controller.popularMovieList;
                            break;
                          case 2:
                            movieList = controller.upcomingMovieList;
                            break;
                          case 0:
                          default:
                            movieList = controller.topRatedMovieList;
                            break;
                        }

                        if (movieList.isEmpty) {
                          return EmptyStateView(
                            key: UniqueKey(),
                            title: 'movie',
                            onRetry: controller.onMovieRetry,
                          );
                        }

                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            controller: controller.forYouScrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: movieList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final MovieInfo info = movieList[index];
                              return MovieCover(
                                key: ValueKey(
                                  '${HomeKey.movieListingForYouItem.value}_${controller.currentTabIdx}_${info.title}',
                                ),
                                info: info,
                                onDetailTap: () => controller.goToMovieDetail(
                                  info,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            );
          }),
        ],
      ),
    );
  }
}
