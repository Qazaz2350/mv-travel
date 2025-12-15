import 'package:flutter/material.dart';
import 'package:mvtravel/model/onboarding/onboarding_model.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  final List<OnboardingData> pages = [
    OnboardingData(
      image: 'assets/onboarding/onboarding2.png',
      title: 'Apply for Visa Easily',
      description: 'Complete your visa application in just a few simple steps.',
    ),
    OnboardingData(
      image: 'assets/onboarding/onboarding3.png',
      title: 'Upload Your Documents',
      description: 'Securely Upload your passport and required document.',
    ),
    OnboardingData(
      image: 'assets/onboarding/onboarding4.png',
      title: 'Track Your Application',
      description: 'Monitor every step of your visa process in real time',
    ),
  ];

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
