import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:janadem/screens/splash_screen.dart';
import 'package:oktoast/oktoast.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return OKToast(
      child: GetMaterialApp(
        title: 'JanaDem',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}