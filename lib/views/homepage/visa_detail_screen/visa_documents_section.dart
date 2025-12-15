// import 'package:flutter/material.dart';
// import 'package:mvtravel/view_model/visa_detail_view_model/visa_detail_view_model.dart';
// import 'package:provider/provider.dart';


// class VisaDocumentsSection extends StatelessWidget {
//   const VisaDocumentsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<VisaDetailViewModel>();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Documents Required',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 16),
//           ...vm.documents.map(
//             (doc) => Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: _buildDocumentItem(doc.title, doc.subtitle),
//             ),
//           ),
//           const Divider(),
//         ],
//       ),
//     );
//   }

//   Widget _buildDocumentItem(String title, String subtitle) {
//     return Row(
//       children: [
//         const Icon(Icons.check_circle, color: Colors.green),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title),
//             Text(subtitle, style: const TextStyle(color: Colors.grey)),
//           ],
//         ),
//       ],
//     );
//   }
// }
