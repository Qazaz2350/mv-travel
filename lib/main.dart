import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/onboarding/splash_view_model.dart';
import 'package:mvtravel/views/onboarding/onboarding.dart';
import 'package:mvtravel/views/onboarding/splash_screen.dart';
// import 'package:mvtravel/views/homepage/visa_detail_screen/visa_detail_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        // Add other ViewModels here later
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: child,
            debugShowCheckedModeBanner: false,
            routes: {
              '/onboarding': (context) => const OnboardingScreen(),
              // Add other routes if needed
            },
          );
        },
        child: const SplashScreen(),
      ),
    );
  }
}
