// import 'package:flutter/material.dart';
// import 'package:mvtravel/view_model/visa_detail_view_model/visa_detail_view_model.dart';
// import 'package:provider/provider.dart';

// class VisaInfoSection extends StatelessWidget {
//   const VisaInfoSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<VisaDetailViewModel>();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Visa Information',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 16),
//           _buildInfoRow(
//             'Visa Type:',
//             vm.visaInfo.visaType,
//             'Validity:',
//             vm.visaInfo.validityPeriod,
//           ),
//           const SizedBox(height: 8),
//           _buildInfoRow(
//             'Entry:',
//             vm.visaInfo.entry,
//             'Length of stay:',
//             vm.visaInfo.lengthOfStay,
//           ),
//           const SizedBox(height: 8),
//           const Divider(),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//     String label1,
//     String value1,
//     String label2,
//     String value2,
//   ) {
//     return Row(
//       children: [
//         Expanded(child: Text('$label1 $value1')),
//         Expanded(child: Text('$label2 $value2')),
//       ],
//     );
//   }
// }
