import 'package:flutter/material.dart';
import 'package:mvtravel/model/home_page_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import 'package:cloud_firestore/cloud_firestore.dart';

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

    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    // ===============================
    // 🔹 FETCH USER NAME DYNAMICALLY
    // ===============================
    final fb_auth.User? firebaseUser =
        fb_auth.FirebaseAuth.instance.currentUser;

    String userName = "Pending";

    if (firebaseUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (doc.exists) {
        userName = doc.data()?['fullName'] ?? "Pending";
      }
    }

    // ===============================
    // 🔹 HOME DATA (UNCHANGED STRUCTURE)
    // ===============================
    homeData = HomeData(
      user: User(name: userName), // ✅ ONLY CHANGE (was "Qazaz")

      featuredDestinations: [
        TravelDestination(
          country: "Pakistan",
          cityName: "Islamabad",
          imageUrl: "assets/home/islamabad_home.png",
          formattedArrival: "Get on 28 Nov, 2025 - 5:55 PM",
          visaType: "Tourist Visa",
          entry: "Single Entry",
          lengthOfStay: "30 Days",
          price: 20000,
          documents: ["Passport", "Photo"],
          faqs: [
            FAQItem(
              question: "Can I change my plan later?",
              answer:
                  "Yes, you can upgrade or downgrade your plan at any time.",
            ),
            FAQItem(
              question: "What is your cancellation policy?",
              answer:
                  "You can cancel anytime. Access remains active till billing ends.",
            ),
          ],
        ),
        TravelDestination(
          country: "France",
          cityName: "Paris",
          imageUrl: "assets/home/france.png",
          formattedArrival: "Get on 15 Dec, 2025 - 3:30 PM",
          visaType: "Tourist Visa",
          entry: "Multiple Entry",
          lengthOfStay: "90 Days",
          price: 35000,
          documents: ["Passport", "Photo", "Travel Insurance"],
          faqs: [
            FAQItem(question: "Is travel insurance required?", answer: "Yes"),
            FAQItem(question: "Visa fee refundable?", answer: "No"),
          ],
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

  void openDocuments() {}
  void viewAllApplications() {}
  void applyForVisa() {}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
