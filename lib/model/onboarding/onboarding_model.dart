class OnboardingData {
  final String image;
  final String title;
  final String description;
  final bool isFirstPage;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
    this.isFirstPage = false,
  });
}
