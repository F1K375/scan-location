import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rsud/router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), (){
      Get.offAndToNamed(AppRoute.home);
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("RSUD"))
          ],
        ),
      ),
    );
  }
}
