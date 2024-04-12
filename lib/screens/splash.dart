import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed/screens/dashboard.dart';

import '../extensions/colors.dart';
import '../extensions/style.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // authController.languageValue(languageController.selectedLanguage.value);
    // subscribeFcmTopic();
    _navigateToHome();
  }
  // subscribeFcmTopic() async{
  //   await FirebaseMessaging.instance.subscribeToTopic(UrlConstant.fcmTopic);
  // }
  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () async {
      Get.offAll(() =>  DashboardScreen());

      // String token = await authPreference.getToken();
      // debugPrint(token);
      // if (token.isNotEmpty) {
      //   Get.offAll(() => const DashBoard());
      // } else {
      //   Get.offAll(() => const LoginScreen());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/icons/ic_logo.png',
                  width: 196,
                  height: 159,
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      'MADE WITH \u2764️ IN INDIA'.tr,
                      textAlign: TextAlign.center,
                      style: fontRegularStyle(color: ColorResources.blackColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Developed By Harsh Shambhuwani'.tr,
                      textAlign: TextAlign.center,
                      style: fontRegularStyle(color: ColorResources.blackColor, fontSize: 14),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
