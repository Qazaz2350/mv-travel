// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:io';
// import 'package:mvtravel/utilis/FontSizes.dart';
// import 'package:mvtravel/utilis/colors.dart';

// import 'package:mvtravel/utilis/nav.dart';

// // Import your custom classes (adjust the paths as per your project structure)
// // import 'package:mvtravel/utilis/AppColors.dart';
// // import 'package:mvtravel/utilis/FontSizes.dart';
// // import 'package:mvtravel/utilis/Nav.dart';
// // import 'package:mvtravel/utilis/ActionButton.dart';

// class ApplyProcess extends StatefulWidget {
//   const ApplyProcess({Key? key}) : super(key: key);

//   @override
//   State<ApplyProcess> createState() => _ApplyProcessState();
// }

// class _ApplyProcessState extends State<ApplyProcess> {
//   int _currentStep = 0;
//   File? _photoFile;
//   File? _passportFile;

//   final ImagePicker _picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.black),
//           onPressed: () => Nav.pop(context),
//         ),
//         title: Text(
//           'Apply to Germany',
//           style: TextStyle(
//             color: AppColors.black,
//             fontSize: FontSizes.f20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Custom Progress Stepper Header
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//             child: Row(
//               children: [
//                 _buildStepItem(
//                   icon: Icons.photo_library_outlined,
//                   label: 'Photo',
//                   stepIndex: 0,
//                 ),
//                 _buildStepLine(0),
//                 _buildStepItem(
//                   icon: Icons.description_outlined,
//                   label: 'Passport',
//                   stepIndex: 1,
//                 ),
//                 _buildStepLine(1),
//                 _buildStepItem(
//                   icon: Icons.info_outline,
//                   label: 'Detail',
//                   stepIndex: 2,
//                 ),
//                 _buildStepLine(2),
//                 _buildStepItem(
//                   icon: Icons.check_circle_outline,
//                   label: 'Checkout',
//                   stepIndex: 3,
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(height: 16.h),

//           // Stepper Content
//           Expanded(child: _buildStepContent()),

//           // Bottom Action Buttons
//           _buildBottomButtons(),
//         ],
//       ),
//     );
//   }

//   Widget _buildStepContent() {
//     switch (_currentStep) {
//       case 0:
//         return _buildPhotoUploadStep();
//       case 1:
//         return _buildPassportUploadStep();
//       case 2:
//         return _buildDetailStep();
//       case 3:
//         return _buildCheckoutStep();
//       default:
//         return _buildPhotoUploadStep();
//     }
//   }

//   // Step 1: Photo Upload
//   Widget _buildPhotoUploadStep() {
//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 16.w),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Upload Photo',
//               style: TextStyle(
//                 fontSize: FontSizes.f20,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.black,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Lorem ipsum dolor sit amet consectetur. Vestibulum malesuada in amet urna.',
//               style: TextStyle(
//                 fontSize: FontSizes.f14,
//                 color: AppColors.grey2,
//                 height: 1.5,
//               ),
//             ),
//             SizedBox(height: 24.h),

//             // Upload Box
//             if (_photoFile == null)
//               GestureDetector(
//                 onTap: () {
//                   _showUploadOptions(isPhoto: true);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 48.h),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: AppColors.grey1,
//                       width: 2,
//                       style: BorderStyle.solid,
//                     ),
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 56.w,
//                         height: 56.w,
//                         decoration: BoxDecoration(
//                           color: AppColors.grey,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.file_upload_outlined,
//                           color: AppColors.grey2,
//                           size: 28.sp,
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         'Tap to Upload',
//                         style: TextStyle(
//                           fontSize: FontSizes.f16,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.black,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         'JPG, PNG,PDF, Max 5MB',
//                         style: TextStyle(
//                           fontSize: FontSizes.f12,
//                           color: AppColors.grey2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             else
//               _buildUploadedFilePreview(_photoFile!, () {
//                 setState(() {
//                   _photoFile = null;
//                 });
//               }),
//           ],
//         ),
//       ),
//     );
//   }

//   // Step 2: Passport Upload
//   Widget _buildPassportUploadStep() {
//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 16.w),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Upload Passport',
//               style: TextStyle(
//                 fontSize: FontSizes.f20,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.black,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Please upload a clear copy of your passport. Make sure all details are visible.',
//               style: TextStyle(
//                 fontSize: FontSizes.f14,
//                 color: AppColors.grey2,
//                 height: 1.5,
//               ),
//             ),
//             SizedBox(height: 24.h),

//             if (_passportFile == null)
//               GestureDetector(
//                 onTap: () {
//                   _showUploadOptions(isPhoto: false);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 48.h),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.grey1, width: 2),
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 56.w,
//                         height: 56.w,
//                         decoration: BoxDecoration(
//                           color: AppColors.grey,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.file_upload_outlined,
//                           color: AppColors.grey2,
//                           size: 28.sp,
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       Text(
//                         'Tap to Upload',
//                         style: TextStyle(
//                           fontSize: FontSizes.f16,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.black,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         'JPG, PNG, PDF, Max 5MB',
//                         style: TextStyle(
//                           fontSize: FontSizes.f12,
//                           color: AppColors.grey2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             else
//               _buildUploadedFilePreview(_passportFile!, () {
//                 setState(() {
//                   _passportFile = null;
//                 });
//               }),
//           ],
//         ),
//       ),
//     );
//   }

//   // Step 3: Detail Step
//   Widget _buildDetailStep() {
//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 16.w),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Personal Details',
//               style: TextStyle(
//                 fontSize: FontSizes.f20,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.black,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Please fill in your personal information.',
//               style: TextStyle(
//                 fontSize: FontSizes.f14,
//                 color: AppColors.grey2,
//                 height: 1.5,
//               ),
//             ),
//             SizedBox(height: 24.h),
//             _buildTextField('Full Name', 'Enter your full name'),
//             SizedBox(height: 16.h),
//             _buildTextField('Date of Birth', 'DD/MM/YYYY'),
//             SizedBox(height: 16.h),
//             _buildTextField('Nationality', 'Enter your nationality'),
//             SizedBox(height: 16.h),
//             _buildTextField('Phone Number', '+92 xxx xxx xxxx'),
//           ],
//         ),
//       ),
//     );
//   }

//   // Step 4: Checkout Step
//   Widget _buildCheckoutStep() {
//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 16.w),
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Review & Checkout',
//               style: TextStyle(
//                 fontSize: FontSizes.f20,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.black,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Please review your application before submitting.',
//               style: TextStyle(
//                 fontSize: FontSizes.f14,
//                 color: AppColors.grey2,
//                 height: 1.5,
//               ),
//             ),
//             SizedBox(height: 24.h),
//             _buildReviewItem(
//               'Photo',
//               _photoFile != null ? 'Uploaded ✓' : 'Not uploaded',
//             ),
//             SizedBox(height: 12.h),
//             _buildReviewItem(
//               'Passport',
//               _passportFile != null ? 'Uploaded ✓' : 'Not uploaded',
//             ),
//             SizedBox(height: 12.h),
//             _buildReviewItem('Personal Details', 'Completed ✓'),
//             SizedBox(height: 24.h),
//             Container(
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: AppColors.grey,
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Amount',
//                     style: TextStyle(
//                       fontSize: FontSizes.f16,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.black,
//                     ),
//                   ),
//                   Text(
//                     '\$250',
//                     style: TextStyle(
//                       fontSize: FontSizes.f20,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.blue2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUploadedFilePreview(File file, VoidCallback onRemove) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.grey,
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60.w,
//             height: 60.w,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.r),
//               image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   file.path.split('/').last,
//                   style: TextStyle(
//                     fontSize: FontSizes.f14,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.black,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   'Uploaded successfully',
//                   style: TextStyle(
//                     fontSize: FontSizes.f12,
//                     color: AppColors.green1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.close, color: AppColors.grey2),
//             onPressed: onRemove,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: FontSizes.f14,
//             fontWeight: FontWeight.w600,
//             color: AppColors.black,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextField(
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: AppColors.grey2),
//             filled: true,
//             fillColor: AppColors.grey,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 14.h,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildReviewItem(String title, String status) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.grey,
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: FontSizes.f14,
//               fontWeight: FontWeight.w600,
//               color: AppColors.black,
//             ),
//           ),
//           Text(
//             status,
//             style: TextStyle(
//               fontSize: FontSizes.f14,
//               color: status.contains('✓') ? AppColors.green1 : AppColors.grey2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStepItem({
//     required IconData icon,
//     required String label,
//     required int stepIndex,
//   }) {
//     bool isActive = _currentStep == stepIndex;
//     bool isCompleted = _currentStep > stepIndex;

//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             width: 32.w,
//             height: 32.w,
//             decoration: BoxDecoration(
//               color: isActive || isCompleted
//                   ? AppColors.blue2
//                   : Colors.transparent,
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: isActive || isCompleted
//                     ? AppColors.blue2
//                     : AppColors.grey1,
//                 width: 2,
//               ),
//             ),
//             child: Icon(
//               icon,
//               color: isActive || isCompleted ? Colors.white : AppColors.grey1,
//               size: 16.sp,
//             ),
//           ),
//           SizedBox(height: 6.h),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: FontSizes.f12,
//               color: isActive ? AppColors.blue2 : AppColors.grey2,
//               fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStepLine(int stepIndex) {
//     bool isCompleted = _currentStep > stepIndex;
//     return Container(
//       width: 20.w,
//       height: 2.h,
//       color: isCompleted ? AppColors.blue2 : AppColors.grey1,
//       margin: EdgeInsets.only(bottom: 20.h),
//     );
//   }

//   Widget _buildBottomButtons() {
//     if (_currentStep == 0 || _currentStep == 1) {
//       return Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(16.w),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   _pickImageFromGallery(_currentStep == 0);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFE3F2FD),
//                   foregroundColor: AppColors.blue2,
//                   padding: EdgeInsets.symmetric(vertical: 14.h),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.upload_outlined, size: 20.sp),
//                     SizedBox(width: 8.w),
//                     Text(
//                       'Upload',
//                       style: TextStyle(
//                         fontSize: FontSizes.f16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   _pickImageFromCamera(_currentStep == 0);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: AppColors.black,
//                   padding: EdgeInsets.symmetric(vertical: 14.h),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                     side: BorderSide(color: AppColors.grey1, width: 1.5),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.camera_alt_outlined, size: 20.sp),
//                     SizedBox(width: 8.w),
//                     Text(
//                       'Live Capture',
//                       style: TextStyle(
//                         fontSize: FontSizes.f16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(16.w),
//         child: Row(
//           children: [
//             if (_currentStep > 0)
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _currentStep--;
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: AppColors.black,
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                       side: BorderSide(color: AppColors.grey1, width: 1.5),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: Text(
//                     'Back',
//                     style: TextStyle(
//                       fontSize: FontSizes.f16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             if (_currentStep > 0) SizedBox(width: 12.w),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_currentStep < 3) {
//                     setState(() {
//                       _currentStep++;
//                     });
//                   } else {
//                     // Submit application
//                     _showSuccessDialog();
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.blue2,
//                   foregroundColor: Colors.white,
//                   padding: EdgeInsets.symmetric(vertical: 14.h),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Text(
//                   _currentStep == 3 ? 'Submit' : 'Continue',
//                   style: TextStyle(
//                     fontSize: FontSizes.f16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void _showUploadOptions({required bool isPhoto}) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       builder: (context) => Container(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.photo_library, color: AppColors.blue2),
//               title: Text('Choose from Gallery'),
//               onTap: () {
//                 Nav.pop(context);
//                 _pickImageFromGallery(isPhoto);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.camera_alt, color: AppColors.blue2),
//               title: Text('Take Photo'),
//               onTap: () {
//                 Nav.pop(context);
//                 _pickImageFromCamera(isPhoto);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImageFromGallery(bool isPhoto) async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         if (isPhoto) {
//           _photoFile = File(image.path);
//         } else {
//           _passportFile = File(image.path);
//         }
//       });
//     }
//   }

//   Future<void> _pickImageFromCamera(bool isPhoto) async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       setState(() {
//         if (isPhoto) {
//           _photoFile = File(image.path);
//         } else {
//           _passportFile = File(image.path);
//         }
//       });
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         title: Column(
//           children: [
//             Icon(Icons.check_circle, color: AppColors.green1, size: 64.sp),
//             SizedBox(height: 16.h),
//             Text('Application Submitted!'),
//           ],
//         ),
//         content: Text(
//           'Your visa application has been submitted successfully.',
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Nav.pop(context);
//               Nav.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }
