import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/global/movie_manager.dart';
import 'package:wizlah_assignment/global/person_manager.dart';
import 'package:wizlah_assignment/model/enum/home/common_enum.dart';
import 'package:wizlah_assignment/model/movie/movie_info.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/navigator/routes.dart';
import 'package:wizlah_assignment/util/debounce.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Variable

  /// Movie Result
  List<MovieInfo> nowPlayingMovieList = <MovieInfo>[];
  List<MovieInfo> topRatedMovieList = <MovieInfo>[];
  List<MovieInfo> upcomingMovieList = <MovieInfo>[];
  List<MovieInfo> popularMovieList = <MovieInfo>[];

  final ScrollController forYouScrollController = ScrollController();

  /// Search Result
  final double _scrollThreshold = 400;
  ScrollController searchScrollController = ScrollController();
  bool isSearching = false;
  int searchPage = 1;
  RxList<MovieInfo> searchMovieList = <MovieInfo>[].obs;

  RxBool showSearchResult = false.obs;

  /// Person Result
  ScrollController personScrollController = ScrollController();
  bool isPersonLoading = false;
  int personPage = 1;
  RxList<PersonInfo> popularPersonList = <PersonInfo>[].obs;
  int personFetchTimestamp = 0;

  HomeLoadingState state = HomeLoadingState.isLoading;

  RxBool isLoading = false.obs;

  late final PageController homePageController;
  int bottomNavIdx = 0;

  late final TabController forYouTabController;
  int currentTabIdx = 0;

  // UI State
  // search editing controller
  final TextEditingController searchController = TextEditingController();
  final Debouncer _debounce = Debouncer(
    milliseconds: 500,
  );

  // Page LifeCycle
  @override
  void onInit() {
    super.onInit();
    homePageController = PageController();
    forYouTabController = TabController(length: 3, vsync: this);

    searchController.addListener(onSearchTextChanged);
    searchScrollController.addListener(onSearchScrollListener);

    personScrollController.addListener(onPersonScrollListener);

    initMovieList();
    initPersonList();
  }

  @override
  void onClose() {
    searchScrollController.removeListener(onSearchScrollListener);
    searchController.removeListener(onSearchTextChanged);
    searchController.dispose();

    personScrollController.removeListener(onPersonScrollListener);
    super.onClose();
  }

  // Method

  /// Movie initialized
  void initMovieList() {
    nowPlayingMovieList = MovieManager().nowPlayingMovieList;
    topRatedMovieList = MovieManager().topRatedMovieList;
    upcomingMovieList = MovieManager().upcomingMovieList;
    popularMovieList = MovieManager().popularMovieList;

    if (nowPlayingMovieList.isEmpty &&
        topRatedMovieList.isEmpty &&
        upcomingMovieList.isEmpty &&
        popularMovieList.isEmpty) {
      state = HomeLoadingState.emptyState;
    } else {
      state = HomeLoadingState.none;
    }

    initMovieListAsync();
  }

  /// Fetch Remote movie data
  Future<void> initMovieListAsync() async {
    isLoading.value = true;
    await getPlayingMovieList();
    await getTopRatedMovieList();
    await getUpcomingMovieList();
    await getPopularMovieList();
    isLoading.value = false;

    update(['now_playing', 'for_you'].toList());
  }

  Future<void> getPlayingMovieList() async {
    List<MovieInfo> latestMovieList = await MovieManager().getRemoteMovieList();

    if (latestMovieList.isNotEmpty) {
      nowPlayingMovieList = latestMovieList;
    }
  }

  Future<void> getTopRatedMovieList() async {
    List<MovieInfo> latestMovieList =
        await MovieManager().getRemoteTopRatedMovieList();

    if (latestMovieList.isNotEmpty) {
      topRatedMovieList = latestMovieList;
    }
  }

  Future<void> getUpcomingMovieList() async {
    List<MovieInfo> latestMovieList =
        await MovieManager().getRemoteUpcomingMovieList();

    if (latestMovieList.isNotEmpty) {
      upcomingMovieList = latestMovieList;
    }
  }

  Future<void> getPopularMovieList() async {
    List<MovieInfo> latestMovieList =
        await MovieManager().getRemotePopularMovieList();

    if (latestMovieList.isNotEmpty) {
      popularMovieList = latestMovieList;
    }
  }

  /// People Initialized
  void initPersonList() {
    popularPersonList.assignAll(PersonManager().popularPersonList);
  }

  Future<void> getPopularPersonList({int page = 1}) async {
    personFetchTimestamp = DateTime.now().millisecondsSinceEpoch;

    List<PersonInfo> infoResults = await PersonManager().getRemotePersonInfo(
      page: page,
    );

    if (page != 1) {
      popularPersonList.addAll(infoResults);
    } else {
      popularPersonList.assignAll(infoResults);
    }

    isPersonLoading = false;
  }

  void getSearchResult({int page = 1}) async {
    List<MovieInfo> searchResults = await MovieManager().getSearchedMovieResult(
      searchController.text.trim(),
      page: page,
    );

    if (page != 1) {
      searchMovieList.addAll(searchResults);
    } else {
      searchMovieList.assignAll(searchResults);
    }
    isSearching = false;
  }

  /// Navigate to Movie detail
  void goToMovieDetail(MovieInfo info) => Routes.toMovieDetail(info);

  /// Navigate to Person detail
  void goToPersonDetail(PersonInfo info) => Routes.toPersonDetail(info);

  /// UI Listener
  void onSearchTextChanged() {
    if (searchController.text.trim().isEmpty) {
      _debounce.dispose();
      searchMovieList.clear();
      showSearchResult.value = false;
      return;
    }

    showSearchResult.value = true;
    _debounce.run(() {
      getSearchResult();
    });
  }

  void onSearchScrollListener() {
    // fetch more result from search
    if (!isSearching &&
        searchScrollController.offset + _scrollThreshold >
            searchScrollController.position.maxScrollExtent) {
      isSearching = true;
      searchPage += 1;
      getSearchResult(page: searchPage);
    }
  }

  void onPersonScrollListener() {
    // fetch more result from person
    // fetch more result from search
    if (!isPersonLoading &&
        personScrollController.offset + _scrollThreshold >
            personScrollController.position.maxScrollExtent) {
      isPersonLoading = true;
      personPage += 1;
      getPopularPersonList(page: personPage);
    }
  }

  /// UI Interaction Method
  void onForYouTabChanged(int index) {
    currentTabIdx = index;

    update(['for_you'].toList());
  }

  void onBottomNavTabChanged(int index) {
    bottomNavIdx = index;
    homePageController.jumpToPage(index);

    if (index == 2 &&
        DateTime.now().millisecondsSinceEpoch - personFetchTimestamp > 3600) {
      getPopularPersonList();
    }

    update(['home'].toList());
  }
}
