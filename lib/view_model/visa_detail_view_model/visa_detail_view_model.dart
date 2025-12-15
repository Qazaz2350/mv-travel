// import 'package:flutter/material.dart';
// import 'package:mvtravel/model/visa_detail_model/VisaInfoModel%20.dart';

// class VisaDetailViewModel extends ChangeNotifier {
//   int expandedIndex = -1;

//   void toggleFAQ(int index) {
//     if (expandedIndex == index) {
//       expandedIndex = -1;
//     } else {
//       expandedIndex = index;
//     }
//     notifyListeners();
//   }

//   List<VisaInfo> visaInfoList = [
//     VisaInfo(
//       visaType: 'Tourist',
//       validityPeriod: 'Tourist',
//       entry: 'Single Entry',
//       lengthOfStay: '30 days',
//     ),
//   ];

//   List<Document> documentsRequired = [
//     Document(
//       title: 'Passport',
//       subtitle: 'Auto-Scanned. Auto-Filled No manual Error',
//     ),
//     Document(
//       title: 'Visa Photo',
//       subtitle: 'Auto-Scanned. Auto-Filled No manual Error',
//     ),
//   ];

//   List<FAQ> faqs = [
//     FAQ(
//       question: 'Is there a free trial available?',
//       answer:
//           'Yes, you can try us for free for 30 days. If you want, we\'ll provide you with a free, personalized 30-minute onboarding call.',
//     ),
//     FAQ(question: 'Can I change my plan later?', answer: ''),
//     FAQ(question: 'What is your cancellation policy?', answer: ''),
//     FAQ(question: 'Can other info be added to an invoice?', answer: ''),
//     FAQ(question: 'How does billing work?', answer: ''),
//     FAQ(question: 'How do I change my account email?', answer: ''),
//   ];
// }
