import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/model/enum/home/home_key.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/home_view.dart';

import 'api/mock_movie_list_api.dart';

void main() {
  Future<List<MovieInfo>> getPlayingMovieList() async {
    return MockMovieListApi.getNowPlayingList();
  }

  Future<List<MovieInfo>> getTopRatedMovieList() async {
    return MockMovieListApi.getTopRatedList();
  }

  Future<List<MovieInfo>> getUpcomingMovieList() async {
    return MockMovieListApi.getUpcomingMovie();
  }

  Future<List<MovieInfo>> getPopularMovieList() async {
    return MockMovieListApi.getPopularList();
  }

  testWidgets('Display Home UI correctly', (WidgetTester tester) async {
    // Inject ViewController
    Get.put(HomeController());
    final homeController = Get.find<HomeController>();

    await tester.pumpWidget(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wizlah Assignment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        getPages: Routes.getPages,
        home: const HomeView(),
      ),
    );

    if (homeController.nowPlayingMovieList.isEmpty &&
        homeController.topRatedMovieList.isEmpty &&
        homeController.upcomingMovieList.isEmpty &&
        homeController.popularMovieList.isEmpty) {
      // Check Progress Loading
      expect(
        find.byKey(const ValueKey(HomeKey.movieListingLoadingProgress)),
        findsOneWidget,
      );
    }

    // Simulate fetching movie details
    await tester.pumpAndSettle();

    final List<List<MovieInfo>> movieList = await Future.wait([
      getPlayingMovieList(),
      getTopRatedMovieList(),
      getUpcomingMovieList(),
      getPopularMovieList(),
    ]);

    homeController.nowPlayingMovieList = movieList[0];
    homeController.topRatedMovieList = movieList[1];
    homeController.upcomingMovieList = movieList[2];
    homeController.popularMovieList = movieList[3];

    // Verify movie now playing list is ready
    expect(homeController.nowPlayingMovieList.isNotEmpty, true);
    // Verify movie now playing list is ready
    expect(homeController.topRatedMovieList.isNotEmpty, true);
    // Verify movie now playing list is ready
    expect(homeController.upcomingMovieList.isNotEmpty, true);
    // Verify movie now playing list is ready
    expect(homeController.popularMovieList.isNotEmpty, true);

    // refresh build
    homeController.update([
      HomeController.movieMainView,
      HomeController.nowPlaying,
      HomeController.forYou,
    ]);
    // jump to next frame
    await tester.pump();

    final MovieInfo nowPlayingInfo = homeController.nowPlayingMovieList.first;
    // Verify movie title is shown
    expect(
      find.byKey(
        ValueKey(
          '${HomeKey.movieListingTitle.value}_${nowPlayingInfo.title}',
        ),
      ),
      findsOneWidget,
    );

    // Verify genres are displayed
    expect(
      find.byKey(
        ValueKey(
          '${HomeKey.movieListingGenre.value}_${nowPlayingInfo.title}',
        ),
      ),
      findsOneWidget,
    );

    // Verify review widgets
    expect(
      find.text('(${nowPlayingInfo.voteCount} review(s))'),
      findsOneWidget,
    );

    // Find the widget that should be dragged
    // final scrollViewFinder = find.byKey(
    //   const ValueKey(HomeKey.movieListingScrollKey),
    // );

    // Simulate dragging by a certain offset
    // await tester.drag(scrollViewFinder, const Offset(0, -500));
    // await tester.pump();

    // Verify For you category
    // expect(find.text('For you'), findsOneWidget);

    // Verify for you movies listing
    // final MovieInfo topRatedInfo = homeController.topRatedMovieList.first;

    // Verify movie title is shown
    // expect(
    //   find.byKey(
    //     ValueKey(
    //       '${HomeKey.movieListingForYouItem.value}_${homeController.currentTabIdx}_${topRatedInfo.title}',
    //     ),
    //   ),
    //   findsOneWidget,
    // );
    //
    // final nowTrendingButton = find.text('Now Trending');
    //
    // await tester.tap(nowTrendingButton);
    // final MovieInfo popularInfo = homeController.popularMovieList.first;
    // expect(
    //   find.byKey(
    //     ValueKey(
    //       '${HomeKey.movieListingForYouItem.value}_${homeController.currentTabIdx}_${popularInfo.title}',
    //     ),
    //   ),
    //   findsOneWidget,
    // );
    //
    // final upcomingButton = find.text('Upcoming Soon');
    // await tester.tap(upcomingButton);
    // final MovieInfo upcomingInfo = homeController.upcomingMovieList.first;
    // expect(
    //   find.byKey(
    //     ValueKey(
    //       '${HomeKey.movieListingForYouItem.value}_${homeController.currentTabIdx}_${upcomingInfo.title}',
    //     ),
    //   ),
    //   findsOneWidget,
    // );
  });
}
