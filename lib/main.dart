import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/apply_process_viewmodel.dart';
import 'package:mvtravel/view_model/onboarding/Purpose_of_visit_ViewModel.dart';
import 'package:mvtravel/view_model/onboarding/splash_view_model.dart';
import 'package:mvtravel/views/home/home_dashboard.dart';
import 'package:mvtravel/views/onboarding/onboarding.dart';
import 'package:mvtravel/views/onboarding/splash_screen.dart';
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
            ],
            child: MaterialApp(
              home: child,
              debugShowCheckedModeBanner: false,
              routes: {'/onboarding': (context) => const OnboardingScreen()},
              theme: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.blue, // Cursor color
                  selectionColor: AppColors.blue, // Highlighted text
                  selectionHandleColor: Colors.blue, // Drag handle color
                ),
              ),
            ),
          );
        },
        child: const SplashScreen(),
      ),
    );
  }
}
