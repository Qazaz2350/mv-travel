class HomeData {
  final User user;
  final List<TravelDestination> featuredDestinations;
  final List<VisaApplication> activeApplications;

  HomeData({
    required this.user,
    required this.featuredDestinations,
    required this.activeApplications,
  });
}

class User {
  final String name;

  User({required this.name});
}

/// 🔥 ONE MODEL FOR CARD + DETAIL PAGE
class TravelDestination {
  // Card (Home Page)
  final String country;
  final String cityName;
  final String imageUrl;
  final String formattedArrival;

  // Detail Page (OPTIONAL)
  final String? visaType;
  final String? entry;
  final String? lengthOfStay;
  final List<String>? documents;
  final List<FAQItem>? faqs;
  final double? price;

  TravelDestination({
    required this.country,
    required this.cityName,
    required this.imageUrl,
    required this.formattedArrival,

    this.visaType,
    this.entry,
    this.lengthOfStay,
    this.documents,
    this.faqs,
    this.price,
    //  required this.cityName,
    // required this.country,
    // required this.imageUrl,
    // required this.formattedArrival,
    // required this.visaType,
    // required this.entry,
    // required this.lengthOfStay,
    // required this.documents,
    // required this.faq,
  });
}

/// FAQ MODEL (used in detail page)
class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

// ------------------ EXISTING (UNCHANGED) ------------------

class VisaApplication {
  final String visaType;
  final VisaStatus status;
  final String fromFlag;
  final String toFlag;
  final String fromToCountry;
  final double progress;
  final String formattedAppliedDate;
  final String feeStatus;

  VisaApplication({
    required this.visaType,
    required this.status,
    required this.fromFlag,
    required this.toFlag,
    required this.fromToCountry,
    required this.progress,
    required this.formattedAppliedDate,
    required this.feeStatus,
  });
}

enum VisaStatus { pending, approved, rejected }

extension VisaStatusExtension on VisaStatus {
  String get displayName {
    switch (this) {
      case VisaStatus.pending:
        return 'Pending';
      case VisaStatus.approved:
        return 'Approved';
      case VisaStatus.rejected:
        return 'Rejected';
    }
  }
}

enum VisaCategory { travel, student, work, investment }

extension VisaCategoryExtension on VisaCategory {
  String get displayName {
    switch (this) {
      case VisaCategory.travel:
        return 'Travel';
      case VisaCategory.student:
        return 'Student';
      case VisaCategory.work:
        return 'Work';
      case VisaCategory.investment:
        return 'Investment';
    }
  }
}
