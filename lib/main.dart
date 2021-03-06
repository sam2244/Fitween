import 'package:fitween1/firebase_options.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/global.dart';
import 'package:fitween1/presenter/model/exercise.dart';
import 'package:fitween1/route.dart';
import 'package:fitween1/view/page/onboarding/onboarding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'fitween',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Fitween());
}

class Fitween extends StatelessWidget {
  const Fitween({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalPresenter.initControllers();
    ExercisePresenter.loadExercises();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          enableLog: false,
          title: 'Fitween',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: FWTheme.lightScheme,
            textTheme: FWTheme.textTheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: FWTheme.darkScheme,
            textTheme: FWTheme.textTheme,
          ),
          home: const OnboardingPage(),
          // home: const DeveloperPage(),
          getPages: FWRoute.getPages,
        );
      },
    );
  }
}
