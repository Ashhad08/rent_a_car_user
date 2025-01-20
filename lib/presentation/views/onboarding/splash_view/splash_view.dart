import 'package:flutter/material.dart';

import '../../../../constants/extensions.dart';
import '../../../../domain/services/session_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../navigation/navigation_helper.dart';
import '../../home_view/home_view.dart';
import '../onboarding_view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    final isLoggedIn = await SessionManager().isLoggedIn();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    if (isLoggedIn) {
      getIt<NavigationHelper>().pushReplacement(context, const HomeView());
    } else {
      getIt<NavigationHelper>()
          .pushReplacement(context, const OnboardingView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.4, 1],
            colors: [
              Color(0xFFFEB317),
              Color(0xFF684805),
              Color(0xFF000000),
            ],
          ),
        ),
        child: Center(
          child: Image.asset(Assets.imagesAppLogo),
        ),
      ),
    );
  }
}
