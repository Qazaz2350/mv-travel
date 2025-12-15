import 'package:flutter/material.dart';
import 'package:mvtravel/model/home/home_page_model.dart';

class FeaturedDestinationsViewModel extends ChangeNotifier {
  final List<TravelDestination> destinations;

  FeaturedDestinationsViewModel({required this.destinations});

  late PageController pageController;
  int currentPage = 0;

  void init() {
    pageController = PageController(viewportFraction: 0.9);
    pageController.addListener(_pageListener);
  }

  void disposeController() {
    pageController.removeListener(_pageListener);
    pageController.dispose();
  }

  void _pageListener() {
    int next = pageController.page!.round();
    if (currentPage != next) {
      currentPage = next;
      notifyListeners();
    }
  }
}
