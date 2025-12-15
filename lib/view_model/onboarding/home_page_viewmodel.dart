import 'package:flutter/material.dart';
import 'package:mvtravel/model/home/home_page_model.dart';

class HomePageViewModel extends ChangeNotifier {
  bool isLoading = false;
  late HomeData homeData;

  VisaCategory selectedCategory = VisaCategory.travel;
  TextEditingController searchController = TextEditingController();

  HomePageViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // Simulate API call

    // Mock Data with MULTIPLE destinations for scrolling
    homeData = HomeData(
      user: User(name: "Qazaz"),
      featuredDestinations: [
        TravelDestination(
          country: "Pakistan",
          cityName: "Islamabad",
          imageUrl: "assets/home/islamabad_home.png",
          formattedArrival: "Get on 28 Nov, 2025 - 5:55 PM",
        ),
        TravelDestination(
          country: "France",
          cityName: "Paris",
          imageUrl: "assets/home/france.png",
          formattedArrival: "Get on 15 Dec, 2025 - 3:30 PM",
        ),
        TravelDestination(
          country: "UAE",
          cityName: "Dubai",
          imageUrl: "assets/images/dubai.jpg",
          formattedArrival: "Get on 20 Jan, 2026 - 11:45 AM",
        ),
        TravelDestination(
          country: "Turkey",
          cityName: "Istanbul",
          imageUrl: "assets/images/istanbul.jpg",
          formattedArrival: "Get on 5 Feb, 2026 - 8:20 PM",
        ),
        TravelDestination(
          country: "UK",
          cityName: "London",
          imageUrl: "assets/images/london.jpg",
          formattedArrival: "Get on 12 Mar, 2026 - 6:15 AM",
        ),
      ],
      activeApplications: [
        VisaApplication(
          visaType: "Work Visa",
          status: VisaStatus.pending,
          fromFlag: "assets/home/PK_flag.png",
          toFlag: "assets/home/berlin_flag.png",
          fromToCountry: "Pakistan to Germany",
          progress: 0.5,
          formattedAppliedDate: "12 - Nov - 2025",
          feeStatus: "Paid",
        ),
        // VisaApplication(
        //   visaType: "Work Visa",
        //   status: VisaStatus.pending,
        //   fromFlag: "assets/home/PK_flag.png",
        //   toFlag: "assets/home/berlin_flag.png",
        //   fromToCountry: "Pakistan to Germany",
        //   progress: 0.5,
        //   formattedAppliedDate: "12 - Nov - 2025",
        //   feeStatus: "Paid",
        // ),
      ],
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshData() async {
    await _loadData();
  }

  void updateCategory(VisaCategory category) {
    selectedCategory = category;
    notifyListeners();
  }

  void openDocuments() {
    // Logic to open documents
  }

  void viewAllApplications() {
    // Logic to view all applications
  }

  void applyForVisa() {
    // Logic to apply for visa
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
