import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/landing.dart';
import 'package:mvtravel/model/visa_tracking_model.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:mvtravel/view_model/documents_view_model.dart';
import 'package:mvtravel/view_model/onboarding/Purpose_of_visit_ViewModel.dart';
import 'package:mvtravel/view_model/onboarding/splash_view_model.dart';
import 'package:mvtravel/view_model/profile_viewmodel.dart';
import 'package:mvtravel/view_model/visa_tracking_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SplashViewModel())],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ApplyProcessViewModel()),
              ChangeNotifierProvider(create: (_) => DetailViewModel()),
              ChangeNotifierProvider(create: (_) => VisitPurposeViewModel()),
              ChangeNotifierProvider(create: (_) => VisaTrackingViewModel()),
              ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
              ChangeNotifierProvider(create: (_) => DocumentsViewModel()),
              
              
              // ChangeNotifierProvider(create: (_) => VisaTrackingModel()),
            ],
            child: MaterialApp(
              
              home: child,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true, // ✅ IMPORTANT
                appBarTheme: const AppBarTheme(
                  surfaceTintColor: Colors.white,

                  elevation: 0,
                  scrolledUnderElevation: 0,
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.blue,
                  selectionColor: AppColors.blue,
                  selectionHandleColor: Colors.blue,
                ),
              ),
            ),
          );
        },
        // child: const OnboardingScreen(),
        child: LandingPage(),
      ),
    );
  }
}
