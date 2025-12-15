// import 'package:flutter/material.dart';
// import 'package:mvtravel/view_model/visa_detail_view_model/visa_detail_view_model.dart';
// import 'package:provider/provider.dart';

// class VisaBottomBar extends StatelessWidget {
//   const VisaBottomBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.read<VisaDetailViewModel>();

//     return Container(
//       padding: const EdgeInsets.all(16),
//       color: Colors.white,
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text('Pay Now'),
//                 Text(
//                   'PKR24,55.49',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: vm.applyNow,
//               child: const Text('Apply Now'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
