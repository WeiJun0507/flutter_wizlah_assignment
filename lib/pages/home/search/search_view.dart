import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/pages/components/empty_state_view.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/movie/components/movie_cover.dart';
import 'package:wizlah_assignment/pages/home/search/components/movie_search_result.dart';
import 'package:wizlah_assignment/pages/home/search/components/skeleton_search_result.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class SearchView extends GetView<HomeController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Container(
          padding: const EdgeInsets.only(
            top: SysSize.paddingHuge,
            left: SysSize.paddingBig,
            right: SysSize.paddingBig,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StText.big(
                'Search',
                style: StandardTextStyle.big.copyWith(
                  fontSize: SysSize.huge,
                ),
              ),
              const SizedBox(height: SysSize.paddingBig),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: controller.searchController,
                  style: StandardTextStyle.normal.copyWith(
                    color: AppColor.whitePrimaryColor,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(SysSize.paddingHuge),
                    ),
                    hintText: 'Search movies, person',
                    hintStyle: StandardTextStyle.normal.copyWith(
                      color: AppColor.whiteSecondaryColor,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: AppColor.whiteSecondaryColor,
                    contentPadding: const EdgeInsets.only(
                      left: SysSize.paddingBig,
                      right: SysSize.paddingBig,
                      bottom: SysSize.paddingSmall,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: SysSize.paddingHuge),
              Expanded(child: _buildMovieContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieContent(context) {
    return Obx(() {
      if (!controller.showSearchResult.value) {
        return _buildDisplayMovieList(context);
      }

      if (controller.searchMovieList.isEmpty) {
        if (controller.isSearching.value) {
          return const SkeletonSearchResult();
        }

        return EmptyStateView(
          onRetry: controller.getSearchResult,
        );
      }

      return ListView.builder(
        controller: controller.searchScrollController,
        itemCount: controller.searchMovieList.length,
        itemBuilder: (BuildContext context, int index) {
          MovieInfo info = controller.searchMovieList[index];
          return MovieSearchResult(
            info: info,
            onDetailTap: () => controller.goToMovieDetail(info),
          );
        },
      );
    });
  }

  Widget _buildDisplayMovieList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Top rated
          ..._buildDisplayTopRatedMovie(context),

          // Upcoming
          ..._buildDisplayUpcomingMovie(context),

          // Popular
          ..._buildDisplayPopularMovie(context),
        ],
      ),
    );
  }

  List<Widget> _buildDisplayTopRatedMovie(BuildContext context) {
    return <Widget>[
      // Top rated
      const StText.big('Top-rated Movie'),

      const SizedBox(height: SysSize.paddingMedium),
      SizedBox(
        height: 250,
        child: controller.topRatedMovieList.isEmpty
            ? const EmptyStateView()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.topRatedMovieList.length,
                itemBuilder: (BuildContext context, int index) {
                  final MovieInfo info = controller.topRatedMovieList[index];
                  return MovieCover(
                    info: info,
                    onDetailTap: () => controller.goToMovieDetail(info),
                  );
                },
              ),
      ),
      const SizedBox(height: SysSize.paddingMedium),
    ];
  }

  List<Widget> _buildDisplayUpcomingMovie(BuildContext context) {
    return <Widget>[
      // Top rated
      const StText.big('Upcoming Movie'),
      const SizedBox(height: SysSize.paddingMedium),
      SizedBox(
        height: 250,
        child: controller.upcomingMovieList.isEmpty
            ? const EmptyStateView()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.upcomingMovieList.length,
                itemBuilder: (BuildContext context, int index) {
                  final MovieInfo info = controller.upcomingMovieList[index];
                  return MovieCover(
                    info: info,
                    onDetailTap: () => controller.goToMovieDetail(info),
                  );
                },
              ),
      ),
      const SizedBox(height: SysSize.paddingMedium),
    ];
  }

  List<Widget> _buildDisplayPopularMovie(BuildContext context) {
    return <Widget>[
      // Top rated
      const StText.big('Most Watched Movie'),
      const SizedBox(height: SysSize.paddingMedium),
      SizedBox(
        height: 250,
        child: controller.popularMovieList.isEmpty
            ? const EmptyStateView()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.popularMovieList.length,
                itemBuilder: (BuildContext context, int index) {
                  final MovieInfo info = controller.popularMovieList[index];
                  return MovieCover(
                    info: info,
                    onDetailTap: () => controller.goToMovieDetail(info),
                  );
                },
              ),
      ),
      const SizedBox(height: SysSize.paddingMedium),
    ];
  }
}
