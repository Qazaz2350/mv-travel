// import 'package:flutter/material.dart';
// import 'package:mvtravel/view_model/visa_detail_view_model/visa_detail_view_model.dart';
// import 'package:provider/provider.dart';

// class VisaFAQSection extends StatelessWidget {
//   const VisaFAQSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<VisaDetailViewModel>();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: vm.faqs.asMap().entries.map((entry) {
//           final index = entry.key;
//           final faq = entry.value;
//           final isExpanded = vm.expandedIndex == index;

//           return Column(
//             children: [
//               ListTile(
//                 title: Text(faq.question),
//                 trailing: Icon(
//                   isExpanded
//                       ? Icons.remove_circle_outline
//                       : Icons.add_circle_outline,
//                 ),
//                 onTap: () => vm.toggleFAQ(index),
//               ),
//               if (isExpanded && faq.answer.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(faq.answer),
//                 ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
